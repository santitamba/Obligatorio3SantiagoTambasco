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
}
