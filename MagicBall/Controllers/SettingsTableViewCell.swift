//
//  SettingsTableViewCell.swift
//  MagicBall
//
//  Created by Alex Hanina on 1/23/22.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var ransomAnswerLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCellLable(text: String) {
        ransomAnswerLable.text = text
    }
}

