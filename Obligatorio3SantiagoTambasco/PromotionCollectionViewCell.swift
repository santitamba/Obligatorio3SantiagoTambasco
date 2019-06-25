//
//  PromotionCollectionViewCell.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 22/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit

class PromotionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var promotionImage: UIImageView!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var stepperView: UIView!
    @IBOutlet weak var quantaLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var promotions = [Promotions]()
    var promotion = Promotions()
    
    func configure() {
        //CinemaLabel.text = cinema.name
        titleLabel.text = promotion.name
        priceLabel.text = "$ " + String(describing: round(100*promotion.price!)/100)
        if let photoUrl = promotion.photoUrl {
            let url = URL(string: photoUrl)
            promotionImage.kf.setImage(with: url)
        }
        
    }
    
}
