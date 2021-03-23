//
//  ConditionTableViewCell.swift
//  Damagesingle
//
//  Created by 花崎諒 on 2021/03/23.
//

import UIKit

class ConditionTableViewCell: UITableViewCell {

    @IBOutlet weak var ConditionLabel: UILabel!
    @IBOutlet weak var ConditionSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
