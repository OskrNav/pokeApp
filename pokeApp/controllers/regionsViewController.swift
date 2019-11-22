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
    var ref: DatabaseReference!
    
   

    var rootRef = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootRef = Database.database().reference(withPath: "teams")
        var refHandle = rootRef.observe(DataEventType.value, with: { (snapshot) in
          let postDict = snapshot.value as? [String : AnyObject] ?? [:]
          print(postDict)
        })
        print("===== ref ===========")
        
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
            print(self.region)
        }
    }
}
