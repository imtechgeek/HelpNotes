//
//  TypeCell.swift
//  HelpNotes
//
//  Created by Usman on 30/11/2019.
//  Copyright © 2019 Usman. All rights reserved.
//

import UIKit

class TypeCell: UITableViewCell {
    @IBOutlet weak var noteTitleLabel: UILabel!
    
    @IBOutlet weak var notesTitleView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        notesTitleView.layer.cornerRadius = notesTitleView.frame.size.height / 2

    }

    
}
