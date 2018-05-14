//
//  Pokemon.swift
//  Pokedex
//
//  Created by Srdjan Djukanovic on 5/4/18.
//  Copyright © 2018 Srdjan Djukanovic. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name : String!
    private var _pokedexId : Int!
    
    var name : String {
        return _name
    }
    
    var pokedexId : Int {
        return _pokedexId
    }
    
    init(name : String, pokedexId : Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
}
