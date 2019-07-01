//
//  FunctionCollectionViewCell.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 19/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit
import Kingfisher

class FunctionCollectionViewCell: UITableViewCell {

    
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var ageRatingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var fun = Function()
    var functions=[Function]()
    var movies = SessionManager.movies
    
    
    func configureCell(){
        var movieFunction = movies.filter({$0.id == fun.movieId})
        titleLabel.text = movieFunction.first?.title
        ageRatingLabel.text = movieFunction.first?.ageRating
        durationLabel.text = String(describing: movieFunction.first?.duration ?? 0) + " min"
        if let text: String = fun.schedule {
            scheduleLabel.text = text + " hs"
        }
    }
    func configureEmptyCell(){
        titleLabel.text = "No hay funcion para esta pelicula"
        ageRatingLabel.text = ""
        durationLabel.text = ""
        scheduleLabel.text = ""
    }
}
