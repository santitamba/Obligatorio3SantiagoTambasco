//
//  CinemaFuncitonTableViewCell.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 25/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit
import Kingfisher

class CinemaFuncitonTableViewCell: UITableViewCell {
    @IBOutlet weak var cinemaNameLabel: UILabel!
    
    @IBOutlet weak var ageRatingLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var fun = Function()
    var functions=[Function]()
    var movies = SessionManager.movies
    var cinemas = SessionManager.cinemas
    
    
    func configureCell(){
        var movieFunction = movies.filter({$0.id == fun.movieId})
        cinemaNameLabel.text = movieFunction.first?.title
        ageRatingLabel.text = movieFunction.first?.ageRating
        durationLabel.text = String(describing: movieFunction.first?.duration ?? 0) + " min"
        if let text: String = fun.schedule {
            scheduleLabel.text = text + " hs"
        }
        
    }
    
    func configureEmptyCell(){
        cinemaNameLabel.text="No hay funciones disponibles"
        ageRatingLabel.text=""
        durationLabel.text=""
        scheduleLabel.text=""
    }
    
    
    

}
