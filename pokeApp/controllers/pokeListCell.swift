//
//  pokeListCell.swift
//  pokeApp
//
//  Created by Oscar Navidad on 11/25/19.
//  Copyright © 2019 Oscar Navidad. All rights reserved.
//

import UIKit

class pokeListCell: UITableViewCell {

    @IBOutlet weak var imagePoke:UIImageView!
    @IBOutlet weak var namePoke:UILabel!
    @IBOutlet weak var numberPoke:UILabel!
    @IBOutlet weak var typePoke:UILabel!
    @IBOutlet weak var descriptionPoke:UILabel!
    @IBOutlet weak var backcard:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
