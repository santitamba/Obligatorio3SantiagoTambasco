//
//  CinemaCollectionViewCell.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 13/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit
import Kingfisher

class CinemaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var CinemaImage: UIImageView!
    @IBOutlet weak var CinemaLabel: UILabel!
    
    var cinema: Cinema!
    var cinemas = [Cinema]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        CinemaImage.layer.cornerRadius = CinemaImage.frame.width / 2
        CinemaImage.layer.masksToBounds = true
    }
    
    
    
    
    func configure() {
        //CinemaLabel.text = cinema.name
        if let photoUrl = cinema.photoUrl {
            let url = URL(string: photoUrl)
            CinemaImage.kf.setImage(with: url)
        }
    }
    
    
}
