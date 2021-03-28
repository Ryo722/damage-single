//
//  CollectionViewCell.swift
//  collectioncheck
//
//  Created by 花崎諒 on 2021/03/26.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ConditionButton: UIButton!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // cellの枠の太さ
        self.layer.borderWidth = 1.0
        // cellの枠の色
        self.layer.borderColor = UIColor.black.cgColor
        // cellを丸くする
        self.layer.cornerRadius = 8.0
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
       contentView.translatesAutoresizingMaskIntoConstraints = false
       contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
       contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
       contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
       contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
   }
}
