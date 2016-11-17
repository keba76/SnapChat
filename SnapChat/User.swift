//
//  User.swift
//  SnapChat
//
//  Created by Ievgen Keba on 11/14/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import UIKit

struct User {
    private var _firstName: String
    private var _uid: String
    
    var firstName: String {
        return _firstName
    }
    var uid: String {
        return _uid
    }
    
    init(firstName: String, uin: String) {
        _firstName = firstName
        _uid = uin
    }
}
