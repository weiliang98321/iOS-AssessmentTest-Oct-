//
//  MatchCandidateTableViewCell.swift
//  NextAcademy - iOS Assessment Test(Tan Wei Liang)
//
//  Created by Tan Wei Liang on 03/10/2017.
//  Copyright © 2017 Tan Wei Liang. All rights reserved.
//

import UIKit

class MatchCandidateTableViewCell: UITableViewCell {
    

    
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
