//
//  MovieViewController.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 1/7/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var ageRatingLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    
    var movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMovieDetails()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setMovieDetails(){
        if let photoUrl = movie.bannerUrl {
            let url = URL(string: photoUrl)
            movieImage.kf.setImage(with: url)
        }
        descriptionTextView.text = movie.description
        directorLabel.text = "Director: " + movie.director!
        ageRatingLabel.text = "Calificacion: " + movie.ageRating!
        durationLabel.text = "Duracion: " + String(describing: movie.duration ?? 0) + " min"
        releaseDateLabel.text = "Fecha de estreno: " + movie.releaseDate!
        titleLabel.text = movie.title
        genreLabel.text = "Genero: " + movie.genre!
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
