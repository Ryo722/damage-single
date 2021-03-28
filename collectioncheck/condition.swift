//
//  condition.swift
//  collectioncheck
//
//  Created by 花崎諒 on 2021/03/26.
//

import Foundation

struct Condition {
    private(set) public var ConditionName: String
    private(set) public var CellColor: String
    
    init(ConditionName: String, CellColor: String){
        self.ConditionName = ConditionName
        self.CellColor = CellColor
    }
}
