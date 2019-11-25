//
//  ViewController.swift
//  pokeApp
//
//  Created by Oscar Navidad on 11/12/19.
//  Copyright © 2019 Oscar Navidad. All rights reserved.
//

import UIKit
import FirebaseUI
import GoogleSignIn

class ViewController: UIViewController {

    let authUI = FUIAuth.defaultAuthUI()
    var handle: AuthStateDidChangeListenerHandle?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        GIDSignIn.sharedInstance()?.presentingViewController = self
        authUI?.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
           // [START auth_listener]
           handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            print("here sign in")
            print(user?.uid)
            GeneralSettings.userUUID =  user?.uid ?? ""
            self.performSegue(withIdentifier: "regionSegue", sender: self)
           }
    }
    override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
         Auth.auth().removeStateDidChangeListener(handle!)
    }

}

extension ViewController : FUIAuthDelegate{
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, url: URL?, error: Error?) {
        print("logged")
    }
    
    
    
}

