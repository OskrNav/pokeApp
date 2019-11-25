//
//  protocolsandExtends.swift
//  pokeApp
//
//  Created by Oscar Navidad on 11/24/19.
//  Copyright © 2019 Oscar Navidad. All rights reserved.
//

import Foundation
import UIKit

protocol PokeDelegate {
    func savePokeTeam(_ name:String, with team:[Int])
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
