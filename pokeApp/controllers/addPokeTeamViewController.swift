//
//  addPokeTeamViewController.swift
//  pokeApp
//
//  Created by Oscar Navidad on 11/24/19.
//  Copyright © 2019 Oscar Navidad. All rights reserved.
//

import UIKit
import AlamofireImage
import SCLAlertView

class addPokeTeamViewController: UIViewController {

    
    var region:Region?
    var pokeEntry:PokeDetail?
    var pokemons:[PokeEntry] = []
    var selectedTeam:[Int] = []
    var delegate:PokeDelegate?
    
    @IBOutlet weak var nameTeamTextField:UITextField!
    @IBOutlet weak var pokeList:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Team"
        self.hideKeyboardWhenTappedAround()
        getData()
        pokeList.allowsMultipleSelection = true
    }

    @IBAction func SaveTeam(_ sender:UIButton){
        let validate = validation()
        if !validate.isError{
            self.delegate?.savePokeTeam(nameTeamTextField.text!, with: selectedTeam)
            self.navigationController?.popViewController(animated: true)
        }else{
            SCLAlertView().showError("PokeApp", subTitle: validate.message) // Error
        }
    }
    
    func validation()->(isError:Bool , message:String){
        var isError = false
        var message = ""
        
        if nameTeamTextField.text!.isEmpty{
            isError = true
            message = "You have to add a name team \n"
        }
        
        if selectedTeam.count <= 2 {
            isError = true
            message = "You have to select at least 3 pokemon in your team"
        }
        return (isError , message)
    }
}


extension addPokeTeamViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! pokeListViewCell
        let data = pokemons[indexPath.row]
        let urlStr = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(data.id).png"
        cell.imagePoke.af_setImage(withURL: URL(string: urlStr)!)
        cell.namePoke.text = data.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if selectedTeam.count >= 6{
            SCLAlertView().showError("PokeApp", subTitle: "You can't select more than 6 pokemon in your team") // Error
            return false
        }else{
            return true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 3
        let spacingBetweenCells:CGFloat = 8
        
        let totalSpacing = (2 * 3) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        
        if let collection = self.pokeList{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = pokemons[indexPath.row]
        self.selectedTeam.append(data.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let data = pokemons[indexPath.row]
        let index = selectedTeam.firstIndex(of: data.id)!
        self.selectedTeam.remove(at: index)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  8
    }
    
}

extension addPokeTeamViewController {
    func getData(){
        //image raw https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png
        //PokeDetail
        let request = Request()
        request.path = (region?.pokedexes.first!.url)!
        request.isCompleteURL = true
        request.method = "GET"
        request.sendRequest(){(response:JSON) in
            self.pokeEntry = PokeDetail(response)
            self.pokemons = self.pokeEntry?.pokemon_entries ?? []
            self.pokeList.reloadData()
        }
    }
}
