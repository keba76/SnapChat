//
//  LoginVC.swift
//  SnapChat
//
//  Created by Ievgen Keba on 11/13/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailField: RoundTextField!
    @IBOutlet weak var passwordField: RoundTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logginPressed(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text, email.characters.count > 0 && password.characters.count > 0 {
            
            AuthService.instance.login(email: email, password: password, onComplete: { (errMsg, data) in
                guard errMsg == nil else {
                    let alert = UIAlertController(title: "Error Authentication", message: errMsg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    return
                }
                self.dismiss(animated: true, completion: nil)
            })
            
        } else {
            let alert = UIAlertController(title: "Username and Password Requared", message: "You must enter both user a name and a password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
}
