//
//  pokeListViewCell.swift
//  pokeApp
//
//  Created by Oscar Navidad on 11/24/19.
//  Copyright © 2019 Oscar Navidad. All rights reserved.
//

import UIKit

class pokeListViewCell: UICollectionViewCell {
    @IBOutlet weak var imagePoke:UIImageView!
    @IBOutlet weak var namePoke:UILabel!
    override var isSelected: Bool {
           didSet {
               if isSelected { // Selected cell
                self.namePoke.textColor = UIColor.white
                self.contentView.layer.cornerRadius = 10
                self.contentView.layer.borderWidth = 0.5
                self.contentView.layer.borderColor = UIColor.clear.cgColor
                self.contentView.layer.masksToBounds = true;
                self.contentView.backgroundColor = UIColor(red:0.31, green:0.65, blue:0.60, alpha:1.0)
                self.layer.masksToBounds = false;
                self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
               } else { // Normal cell
                self.namePoke.textColor =  UIColor.black
                self.contentView.layer.cornerRadius = 0
                self.contentView.layer.borderWidth = 0
                self.contentView.layer.borderColor = UIColor.clear.cgColor
                self.contentView.layer.masksToBounds = false;
                self.contentView.backgroundColor = UIColor.white
                self.layer.masksToBounds = false;
                self.layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
               }
           }
       }
}
