//
//  MovieCollectionViewCell.swift
//  
//
//  Created by Adrian Perez Garrone on 13/6/19.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var MovieImage: UIImageView!
    
    var movie: Movie!
    var movies = [Movie]()
    
    func configure() {
        if let photoUrl = movie.photoUrl {
            let url = URL(string: photoUrl)
            MovieImage.kf.setImage(with: url)
        }
    }
    
}
