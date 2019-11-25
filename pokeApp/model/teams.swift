//
//  teams.swift
//  pokeApp
//
//  Created by Oscar Navidad on 11/24/19.
//  Copyright © 2019 Oscar Navidad. All rights reserved.
//

import Foundation

struct Team {
    var region_id : Int = 0
    var team_name : String = ""
    var user_id : Int = 0
    var pokemon : [Int] = []
    var document_id : String = ""
    init(_ data:[String:Any] , document_id : String ){
        self.region_id = data["region_id"] as? Int ?? 0
        self.team_name = data["team_name"]  as? String ?? ""
        self.user_id = data["user_id"]  as? Int ?? 0
        self.pokemon = data["pokemons"] as? [Int] ?? []
        self.document_id = document_id
    }
}
