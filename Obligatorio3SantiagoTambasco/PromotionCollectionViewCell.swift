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
    //var promotion = Promotions()
    var promotion: Promotions!
    var subtotal = 0
    var delegate: UpdatePromotionDelegate?
    
    func configure() {
        self.stepperView.isHidden = true
        self.addButton.isHidden = false
        self.quantaLabel.text = "0"
        
        let currentQty = promotion.quantity ?? 0
        if currentQty > 0 {
            quantaLabel.text = String(currentQty)
            self.stepperView.isHidden = false
            self.addButton.isHidden = true
        }
        
        
        //CinemaLabel.text = cinema.name
        titleLabel.text = promotion.name
        priceLabel.text = "$ " + String(describing: round(100*promotion.price!)/100)
        if let photoUrl = promotion.photoUrl {
            let url = URL(string: photoUrl)
            promotionImage.kf.setImage(with: url)
        }
        
    }
    
    func updateLabel(add: Bool) {
        var current = getCurrentQty()
        if add {
            current = current + 1
        } else {
            current = current - 1
        }
        quantaLabel.text = String(current)
    }
    
    func getCurrentQty() -> Int {
        if let currentQty = Int(quantaLabel.text ?? "0") {
            return currentQty
        } else {
            return 0
        }
    }
    
    public func changeStepperVisible() {
        self.stepperView.isHidden = !self.stepperView.isHidden
        self.addButton.isHidden = !self.addButton.isHidden
    }
    
    public func changeStepperInVisible() {
        self.stepperView.isHidden = true
        self.addButton.isHidden = false
    }

    
    @IBAction func addButton(_ sender: Any) {
        changeStepperVisible()
        //promotion.quantity=1
        delegate?.add(item: promotion)
        updateLabel(add: true)
    }
    @IBAction func minusButton(_ sender: Any) {
        let current = getCurrentQty()
        if current == 1 {
            changeStepperInVisible()
        } else {
            updateLabel(add: false)
        }
        //promotion.quantity = (promotion.quantity ?? 0) - 1
        delegate?.remove(item: promotion)
    }
    
    @IBAction func plusButton(_ sender: Any) {
        //promotion.quantity = (promotion.quantity ?? 0) + 1
        delegate?.add(item: promotion)
        updateLabel(add: true)
    }
    
    
}
