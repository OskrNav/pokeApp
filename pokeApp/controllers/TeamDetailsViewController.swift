//
//  TeamDetailsViewController.swift
//  pokeApp
//
//  Created by Oscar Navidad on 11/25/19.
//  Copyright © 2019 Oscar Navidad. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var listPoke:UITableView!
    @IBOutlet weak var titleTeam:UILabel!
    
    var team:Team?
    var teamInfo:[Pokemon] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        titleTeam.text = team?.team_name
        listPoke.delegate = self
        listPoke.dataSource = self
        // Do any additional setup after loading the view.
    }


}

//MARK tableView delegate
extension TeamDetailsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! pokeListCell
        let data = teamInfo[indexPath.row]
        cell.namePoke.text = data.name
        cell.numberPoke.text = data.number.description + " Pokedex Number"
        cell.typePoke.text = data.typePoke
        cell.descriptionPoke.text = data.descriptionPoke
        let urlStr = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(data.id).png"
        cell.imagePoke.af_setImage(withURL: URL(string: urlStr)!)
        
        cell.backcard.layer.cornerRadius = 15
        cell.backcard.layer.shadowColor = UIColor.black.cgColor
        
        return cell
    }
}

//MARK: get pokemon info
extension TeamDetailsViewController:NVActivityIndicatorViewable{
    func getData() {
        self.teamInfo = []
        for item in team!.pokemon{
           let request = Request()
           let regionID:Int = (GeneralSettings.DefaultIDRegion == 0) ? 1 : GeneralSettings.DefaultIDRegion
            request.path = "pokemon-species/\(item)"
           request.method = "GET"
           request.sendRequest(){(response:JSON) in
                
            self.teamInfo.append(Pokemon(response))
            self.isFinished()
           }
       }
    }
    
    func isFinished(){
        if self.teamInfo.count == team?.pokemon.count{
            self.listPoke.reloadData()
        }
    }
}
