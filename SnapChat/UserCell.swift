//
//  UserCell.swift
//  SnapChat
//
//  Created by Ievgen Keba on 11/14/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var firstNameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setCheckmark(selected: false)
    }
    
    func updateUI(user: User) {
        self.firstNameLbl.text = user.firstName
    }

    func setCheckmark(selected: Bool) {
        
        let imageStr = selected ? "check2" : "check1"
        
        self.accessoryView = UIImageView(image: UIImage(named: imageStr))
    }

}
