//
//  DetailsTableViewCell.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 28/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var quantLabel: UILabel!
    @IBOutlet weak var subtotalLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var detailItems = [Item]()
    var item = Item()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(){
        descriptionLabel.text = item.description
        quantLabel.text = String(describing: item.quantity ?? 0)
        subtotalLabel.text = "$ " + String(describing: item.price ?? 0)
        
    }
    

    @IBAction func finshPurchaseButton(_ sender: Any) {
    }
    
}
