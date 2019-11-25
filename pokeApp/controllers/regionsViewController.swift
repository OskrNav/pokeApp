//
//  regionsViewController.swift
//  pokeApp
//
//  Created by Oscar Navidad on 11/13/19.
//  Copyright © 2019 Oscar Navidad. All rights reserved.
//

import UIKit
import Firebase
import SCLAlertView

class regionsViewController: UIViewController {

    var region:Region?
    let db = Firestore.firestore()
    var teams:[Team] = []
    @IBOutlet weak var listTeam:UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Teams"
        getData()
        getTeams()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPokeSegue"{
            let controller = segue.destination as! addPokeTeamViewController
            controller.region = self.region
            controller.delegate = self
        }
    }
}

// MARK: TableView delegate

extension regionsViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        let data = teams[indexPath.row]
        cell.textLabel?.text = data.team_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completion in
            
            let data = self!.teams[indexPath.row]
            self!.teams.removeAll(where: {$0.team_name == data.team_name})
            self!.removePokeTeam(team: data)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            completion(true)
        }

        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}


//MARK:  delegate for Poke app
extension regionsViewController : PokeDelegate{
    
    func removePokeTeam(team:Team){
        
        db.collection("teams").document(team.document_id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
                SCLAlertView().showError("PokeApp", subTitle: err as! String) // Error
            } else {
                print("Document successfully removed!")
                SCLAlertView().showSuccess("PokeApp", subTitle: "Remove Successfully")
            }
        }
    }
    func savePokeTeam(_ name:String , with team: [Int]) {
        var ref: DocumentReference? = nil
               ref = db.collection("teams").addDocument(data: [
                   "team_name": name,
                   "user_id":1,
                   "pokemons": team,
                   "region_id" : self.region?.id ?? 0
               ]) { err in
                   if let err = err {
                       print("Error adding document: \(err)")
                    SCLAlertView().showError("PokeApp", subTitle: err as! String) // Error
                   } else {
                       print("Document added with ID: \(ref!.documentID)")
                    SCLAlertView().showSuccess("PokeApp", subTitle: "Save Successfully")
                    self.getTeams()
                   }
               }
    }
    
}


//MARK : Get Data about Pokemon Regions
extension regionsViewController{
    
    func getTeams(){
        db.collection("teams").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.teams = []
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.teams.append(Team(document.data(),document_id: document.documentID))
                }
                print(self.teams)
                self.listTeam.reloadData()
            }
        }
    }
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
