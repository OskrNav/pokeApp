//
//  regionsViewController.swift
//  pokeApp
//
//  Created by Oscar Navidad on 11/13/19.
//  Copyright © 2019 Oscar Navidad. All rights reserved.
//

import UIKit
import FirebaseDatabase

class regionsViewController: UIViewController {

    var region:Region?
    let ref = Database.database().reference(withPath: "teams")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
    }
}


//MARK : Get Data about Pokemon Regions
extension regionsViewController{
    func getData() {
        let request = Request()
        let regionID:Int = (GeneralSettings.DefaultIDRegion == 0) ? 1 : GeneralSettings.DefaultIDRegion
        request.path = "region/\(regionID)"
        request.method = "GET"
        request.sendRequest(){(response:JSON) in
            self.region = Region(data: response)
            
        }
    }
}
