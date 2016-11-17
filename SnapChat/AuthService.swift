//
//  AuthService.swift
//  SnapChat
//
//  Created by Ievgen Keba on 11/13/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Completion = (_ errorMsg: String?, _ data: AnyObject?) -> Void

class AuthService {
    
    private static let _inctance = AuthService()
    
    static var instance: AuthService {
        return _inctance
    }
    
    func login(email: String, password: String, onComplete: Completion?) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                if let errorCode = FIRAuthErrorCode(rawValue: (error!._code)) {
                    if errorCode == .errorCodeUserNotFound {
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                self.handleFirebaseError(error: error as! NSError, onComplete: onComplete)
                            } else {
                                if user?.uid != nil {
                                    
                                    DataService.instance.saveUser(uid: user!.uid)
                                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil {
                                            self.handleFirebaseError(error: error as! NSError, onComplete: onComplete)
                                        }else {
                                            onComplete?(nil, user)
                                        }
                                    })
                                }
                            }
                        })
                    } else {
                        self.handleFirebaseError(error: error as! NSError, onComplete: onComplete)
                    }
                }
            } else {
                onComplete?(nil, user)
            }
        })
    }


    func handleFirebaseError(error: NSError, onComplete: Completion?) {
        
        if let errorCode = FIRAuthErrorCode(rawValue: error.code) {
            switch errorCode {
            case .errorCodeInvalidEmail:
                onComplete?("Invalid email address", nil)
            case .errorCodeWrongPassword:
                onComplete?("Invalid password", nil)
            case .errorCodeEmailAlreadyInUse, .errorCodeAccountExistsWithDifferentCredential:
                onComplete?("Could not create account. Email allready in use", nil)
            default:
                onComplete?("There was a problem authenticating. Try again.", nil)
            }
        }
    }




}
