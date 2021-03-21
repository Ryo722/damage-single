//
//  PokemonTableViewCell.swift
//  Damagesingle
//
//  Created by 花崎諒 on 2021/03/20.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var PokemonNumLabel: UILabel!
    @IBOutlet weak var PokemonDamageLabel: UILabel!
    @IBAction func PokemonDamageStepper(_ sender: UIStepper) {
        let num = Int(sender.value)
        PokemonDamageLabel.text = String(num)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
