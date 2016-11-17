//
//  DataService.swift
//  SnapChat
//
//  Created by Ievgen Keba on 11/14/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

let FIR_CHILD_USER = "user"

class DataService {
    
    private static let _instance = DataService()
    static var instance: DataService {
        return _instance
    }
    
    var mainRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    var userRef: FIRDatabaseReference {
        return mainRef.child(FIR_CHILD_USER)
    }
    
    var mainStorageRef: FIRStorageReference {
        return FIRStorage.storage().reference(forURL: "gs://snapchat-26722.appspot.com")
    }
    
    var videoStorage: FIRStorageReference {
        return mainStorageRef.child("videos")
    }
    
    func saveUser(uid: String) {
        
        let profile: Dictionary<String, AnyObject> = [
            "firstname" : "" as AnyObject,
            "lastname" : "" as AnyObject
        ]
        
        mainRef.child(FIR_CHILD_USER).child(uid).child("profile").setValue(profile)
    }
    
    func sendMediaPullrequest(senderUID: String, sendingTo: Dictionary<String, User>, mediaURL: URL, textSnippet: String? = nil) {
        
        let pr: Dictionary<String, AnyObject> = [
            "mediaURL" : mediaURL.absoluteString as AnyObject,
            "userID" : senderUID as AnyObject,
            "openCount" : 0 as AnyObject,
            "recipiens" : sendingTo.keys as AnyObject
        ]
        
        mainRef.child("pullRequest").childByAutoId().setValue(pr)
    }
}
