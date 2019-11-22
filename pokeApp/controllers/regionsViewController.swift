//
//  regionsViewController.swift
//  pokeApp
//
//  Created by Oscar Navidad on 11/13/19.
//  Copyright © 2019 Oscar Navidad. All rights reserved.
//

import UIKit
import XXXRoundMenuButton
class regionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonMenu = XXXRoundMenuButton();
               self.view.addSubview(buttonMenu);
        print( self.view.frame.size.width)
        buttonMenu.frame = CGRect(x: self.view.frame.size.width  - 200 , y: self.view.frame.size.height - 200, width: 200, height: 200);
        buttonMenu.centerButtonSize = CGSize(width: 44, height: 44);
        buttonMenu.tintColor = UIColor.white;
        buttonMenu.jumpOutButtonOnebyOne = true;
        
        buttonMenu.load(withIcons: [UIImage(named: "icon_can")!,UIImage(named: "icon_pos")!,UIImage(named: "icon_img")!], startDegree: Float(-M_PI), layoutDegree: Float(M_PI/2))
               
               buttonMenu.buttonClickBlock =  {(idx:NSInteger)-> Void in
                   NSLog("%d", idx);
               };
        
        getData()
    }
}


//MARK : Get Data about Pokemon Regions

extension regionsViewController{
    func getData() {
        let request = Request()
        request.path = "region/1"
        request.method = "GET"
        request.sendRequest(){(response:JSON) in 
            
            print(response)
        }
    }
}
