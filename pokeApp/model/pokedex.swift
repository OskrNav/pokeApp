//
//  pokedex.swift
//  pokeApp
//
//  Created by Oscar Navidad on 11/24/19.
//  Copyright © 2019 Oscar Navidad. All rights reserved.
//

import Foundation

struct PokeDetail {
    var id : Int = 0
    var name : String = ""
    var pokemon_entries:[PokeEntry] = []
    
    init(_ data:JSON){
        self.id = data["id"].int ?? 0
        self.name = data["name"].string ?? ""
        if let items = data["pokemon_entries"].array{
            self.pokemon_entries = []
            for item in items{
                self.pokemon_entries.append(PokeEntry(item))
            }
        }
    }
}

struct PokeEntry {
    var id:Int = 0
    var name:String = ""
    
    init(_ data:JSON){
        self.id = data["entry_number"].int ?? 0
        let pokemon_species = data["pokemon_species"]
        self.name = pokemon_species["name"].string ?? ""
    }
}
