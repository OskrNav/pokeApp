//
//  errir.swift
//  Sermon App
//
//  Created by Oscar Navidad on 7/31/19.
//  Copyright © 2019 The Generus Church. All rights reserved.
//

import Foundation
struct errorObject {
    var errors:[errorItem] = []
    init(data:JSON){
        if let items = data.array{
            self.errors = []
            for item in items
            {
                self.errors.append(errorItem(item))
            }
        }
    }
}


struct errorItem {
    var title : String?
    var detail : String?
    
    init(_ data:JSON){
        
        if let title = data["title"].string {
            self.title = title
        }
        
        if let detail = data["detail"].string{
            self.detail = detail
        }
    }
}
