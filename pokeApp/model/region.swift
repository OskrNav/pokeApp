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
    
    init(data:JSON){
        self.name = data["name"].string ?? ""
    }
}
