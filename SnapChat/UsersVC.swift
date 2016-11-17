//
//  UsersVC.swift
//  SnapChat
//
//  Created by Ievgen Keba on 11/14/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var users = [User]()
    private var selectedUsers = Dictionary<String, User>()
    
    private var _videoURL: URL?
    var videoURL:URL? {
        set {
            _videoURL = newValue
        }
        get {
            return _videoURL
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        DataService.instance.userRef.observeSingleEvent(of: .value){(snapshot: FIRDataSnapshot) in
            if let users = snapshot.value as? Dictionary<String, AnyObject> {
                for (key, value) in users {
                    if let dict = value as? Dictionary<String, AnyObject> {
                        if let profile = dict["profile"] as? Dictionary<String, AnyObject> {
                            if let firstname = profile["firstname"] as? String {
                                let uid = key
                                let user = User(firstName: firstname, uin: uid)
                                self.users.append(user)
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationItem.rightBarButtonItem?.isEnabled = true
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: true)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = user
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: false)
        let user = users[indexPath.row]
        selectedUsers[user.uid] = nil
        
        if selectedUsers.count <= 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        let user = users[indexPath.row]
        cell.updateUI(user: user)
        return cell
    }
    
    @IBAction func sendPRBtnPressed(sender: AnyObject) {
        if let url = videoURL {
            let videoName = "\(UUID().uuidString)\(url)"
            let ref = DataService.instance.mainStorageRef.child(videoName)
            _ = ref.putFile(url, metadata: nil, completion: { (storage:FIRStorageMetadata?, err:Error?) in
                if err != nil {
                    print("Error uploading video \(err?.localizedDescription)")
                } else {
                    let downloadURL = storage!.downloadURL()
                    DataService.instance.sendMediaPullrequest(senderUID: (FIRAuth.auth()?.currentUser!.uid)!, sendingTo: self.selectedUsers, mediaURL: downloadURL!, textSnippet: "Coding today was LEGIT!")
                }
            })
            self.dismiss(animated: true, completion: nil)
        }
    }
}
