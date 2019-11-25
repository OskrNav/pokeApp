//
//  Pokemon.swift
//  pokeApp
//
//  Created by Oscar Navidad on 11/25/19.
//  Copyright © 2019 Oscar Navidad. All rights reserved.
//

import Foundation
struct Pokemon {
    var name:String = ""
    var number:Int = 0
    var descriptionPoke:String = ""
    var typePoke:String = ""
    var id:Int = 0
    init(_ data:JSON){
        self.name = data["name"].string ?? ""
        self.number = (data["pokedex_numbers"].array)?.last!["entry_number"].int ?? 0
        let flavor_text_entries = data["flavor_text_entries"].array
        let item = flavor_text_entries![1]
        self.descriptionPoke = item["flavor_text"].string ?? ""
        self.typePoke = (data["genera"].array)?[2]["genus"].string ?? ""
        self.id = data["id"].int ?? 0
    }
}
