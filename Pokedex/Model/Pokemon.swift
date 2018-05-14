//
//  Pokemon.swift
//  Pokedex
//
//  Created by Srdjan Djukanovic on 5/4/18.
//  Copyright © 2018 Srdjan Djukanovic. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name : String!
    private var _pokedexId : Int!
    private var _description : String!
    private var _type : String!
    private var _defense : String!
    private var _height : String!
    private var _weight : String!
    private var _attack : String!
    private var _nextEvolutionName : String!
    private var _nextEvolutionId : String!
    private var _pokemonURL : String!
    private var _pokemonEvolutionURL : String!
    
    var name : String {
        return _name
    }
    
    var pokedexId : Int {
        return _pokedexId
    }
    
    var description : String {
        if _description == nil {
            _description = ""
        }
        
        return _description
    }
    
    var type : String {
        if _type == nil {
            _type = ""
        }
        
        return _type
    }
    
    var defense : String {
        if _defense == nil {
            _defense = ""
        }
        
        return _defense
    }
    
    var height : String {
        if _height == nil {
            _height = ""
        }
        
        return _height
    }
    
    var weight : String {
        if _weight == nil {
            _weight = ""
        }
        
        return _weight
    }
    
    var attack : String {
        if _attack == nil {
            _attack = ""
        }
        
        return _attack
    }
    
    var nextEvolutionName : String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        
        return _nextEvolutionName
    }
    
    var nextEvolutionId : String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        
        return _nextEvolutionId
    }
    
    
    init(name : String, pokedexId : Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        self._pokemonEvolutionURL = "\(URL_BASE)\(URL_EVOLUTION)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetails(completed : DownloadComplete) {
        Alamofire.request(_pokemonURL, method : .get).responseJSON { (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? Int {
                    self._weight = String(weight)
                }
                
                if let height = dict["height"] as? Int {
                    self._height = String(height)
                }
                
                if let types = dict["types"] as? [Dictionary<String,AnyObject>] , types.count > 0 {
                    if let type = types[0]["type"] as? Dictionary<String, String> {
                        if let name = type["name"] as String? {
                            self._type = name.capitalized
                        }
                    }
                    
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let type = types[x]["type"] as? Dictionary<String, String> {
                                if let name = type["name"] as String? {
                                    self._type! += "/\(name.capitalized)"
                                }
                        }
                    }
                }
                
                
                } else {
                    self._type = ""
                }
        }
        
        
    }
        
        completed()
        
        Alamofire.request(_pokemonEvolutionURL, method : .get).responseJSON { (response) in
            if let dictEvl = response.result.value as? Dictionary<String, AnyObject> {
                if let chain = dictEvl["chain"] as? Dictionary<String, AnyObject> {
                    if let evolvesTo = chain["evolves_to"] as? [Dictionary<String, AnyObject>] {
                        if let species = evolvesTo[0]["species"] as? Dictionary<String, String> {
                            if let urlEvolut = species["url"] as String? {
                                let evlId = urlEvolut.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon-species/", with: "")
                                let evlIdcomp = evlId.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionId = evlIdcomp
                            }
                            
                            if let nameEvolut = species["name"] as String? {
                                self._nextEvolutionName = nameEvolut.capitalized
                            }
                        }
                    }
                }
            }
        }
        
        completed()
}

}
