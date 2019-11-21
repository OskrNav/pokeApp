//
//  region.swift
//  pokeApp
//
//  Created by Oscar Navidad on 11/13/19.
//  Copyright © 2019 Oscar Navidad. All rights reserved.
//

import Foundation

struct Region {
    var name:String = ""
    var id : Int = 0
    var pokedexes:[Pokedex] = []
    
    
    init(data:JSON){
        self.name = data["name"].string ?? ""
        self.id = data["id"].int ?? 0
        if let items = data["pokedexes"].array{
            self.pokedexes = []
            for item in items {
                self.pokedexes.append(Pokedex(item))
            }
        }
        
    }
}


struct Pokedex{
    var url:String = ""
    var name:String = ""
    
    init(_ data:JSON){
        self.url = data["url"].string ?? ""
        self.name = data["name"].string ?? ""
    }
}
