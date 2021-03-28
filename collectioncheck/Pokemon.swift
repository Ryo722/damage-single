//
//  Pokemon.swift
//  collectioncheck
//
//  Created by 花崎諒 on 2021/03/27.
//

import Foundation

struct Pokemon {
    private(set) public var PokemonNumLabel : Int
    private(set) public var PokemonDamageLabel : Int

    init(PokemonNumLabel: Int, PokemonDamageLabel: Int) {
        self.PokemonNumLabel = PokemonNumLabel
        self.PokemonDamageLabel = PokemonDamageLabel
    }
}
