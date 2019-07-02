//
//  BillBoardViewController.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 17/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit
import Firebase

class BillBoardViewController: UIViewController {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    @IBOutlet weak var cinemasCollectionView: UICollectionView!
    
    var db: Firestore!
    var movies = [Movie]()
    var movie = Movie()
    var cinemas = [Cinema]()
    var cinema = Cinema()
    var functions = [Function]()
    var function = Function()
    var room = Room()
    var rooms = [Room]()
    var TIndex = 0
    var movieForSegue = Movie()
    var cinemaForSegue = Cinema()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getRooms()
        rooms=[Room]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        getCinemas()
        getMovies()
        getFunctions()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMovies(){
        self.db.collection("movie").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    let docId = document.documentID
                    let id = document.get("id") as! Int
                    let title = document.get("title") as! String
                    let duration = document.get("duration") as! Int
                    let genre = document.get("genre") as! String
                    let photoUrl = document.get("photoUrl") as! String
                    let director = document.get("director") as! String
                    let releaseDate = document.get("releaseDate") as! String
                    let ageRating = document.get("ageRating") as! String
                    let bannerUrl = document.get("bannerUrl") as! String
                    let description = document.get("description") as! String
                    //print(id, title, duration, genre, photoUrl, director, releaseDate, ageRating)
                    self.movie.ageRating=ageRating
                    self.movie.id=id
                    self.movie.title=title
                    self.movie.duration=duration
                    self.movie.genre=genre
                    self.movie.photoUrl=photoUrl
                    self.movie.director=director
                    self.movie.bannerUrl=bannerUrl
                    self.movie.description=description
                    self.movie.releaseDate=releaseDate
                    self.movies.append(self.movie)
                    self.movie = Movie()
                    self.moviesCollectionView.reloadData()
                }
                SessionManager.movies = self.movies

                

            }
        }
    }
    
    
    
    func getCinemas(){
        self.db.collection("cinema").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    let docId = document.documentID
                    let id = document.get("id") as! Int
                    let name = document.get("name") as! String
                    let address = document.get("address") as! String
                    let telephone = document.get("telephone") as! String
                    let photoUrl = document.get("photoUrl") as! String
                    //print(id, title, duration, genre, photoUrl, director, releaseDate, ageRating)
                    self.cinema.id=id
                    self.cinema.name=name
                    self.cinema.address=address
                    self.cinema.telephone=telephone
                    self.cinema.photoUrl=photoUrl
                    self.cinemas.append(self.cinema)
                    self.cinema = Cinema()
                    self.cinemasCollectionView.reloadData()
                }
                SessionManager.cinemas = self.cinemas
            }
        }

    }
    
    func getFunctions(){
        self.db.collection("function").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    let docId = document.documentID
                    let id = document.get("id") as! Int
                    let movieId = document.get("movieId") as! Int
                    let roomId = document.get("roomId") as! Int
                    let cineId = document.get("cineId") as! Int
                    let schedule = document.get("schedule") as! String
                    //print(id, title, duration, genre, photoUrl, director, releaseDate, ageRating)
                    self.function.id=id
                    self.function.movieId=movieId
                    self.function.cineId=cineId
                    self.function.roomId=roomId
                    self.function.schedule=schedule
                    
                    self.functions.append(self.function)
                    self.function = Function()
                }
                SessionManager.functions = self.functions
            }
        }
    }
    
    func getRooms(){
        self.db.collection("room").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                    let docId = document.documentID
                    let id = document.get("id") as! Int
                    let map = document.get("map") as! String
                    //print(id, title, duration, genre, photoUrl, director, releaseDate, ageRating)
                    self.room.id=id
                    self.room.map=map
                    self.rooms.append(self.room)
                    self.room = Room()
                    
                }
                SessionManager.rooms = self.rooms
            }
        }
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FunctionViewSegue" {
            if let destinationVC = segue.destination as? FunctionViewController {
                destinationVC.movie = movieForSegue
                destinationVC.cinemas = cinemas
                destinationVC.functions = functions
            }
        }
        else if segue.identifier == "CinemaFunctionViewSegue"{
            if let destinationVC = segue.destination as? CinemaFunctionViewController {
                destinationVC.cinema = cinemaForSegue
                destinationVC.cinemas = cinemas
                destinationVC.functions = functions
            }
            
        }
    }
    

    
}

extension BillBoardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == moviesCollectionView {
            let padding: CGFloat =  20
            let collectionViewSize = collectionView.frame.size.width - padding
            
            return CGSize(width: collectionViewSize/2, height: collectionViewSize/2 + 60)
        }
        else{
            let padding: CGFloat =  20
            let collectionViewSize = collectionView.frame.size.width - padding
            
            return CGSize(width: collectionViewSize/3, height: collectionViewSize/3 + 60)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == moviesCollectionView {
            //print(movies.count)
            return movies.count
        } else /*if collectionView == cinemasCollectionView*/{
           // print(cinemas.count)
            return cinemas.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == moviesCollectionView {
            movieForSegue = movies[indexPath.row]
            self.performSegue(withIdentifier: "FunctionViewSegue", sender: self)
        }
        else{
            cinemaForSegue = cinemas[indexPath.row]
            self.performSegue(withIdentifier: "CinemaFunctionViewSegue", sender: self)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == moviesCollectionView {
            guard let cellMovie=collectionView.dequeueReusableCell(withReuseIdentifier: "cellMovie", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell()}
            cellMovie.movie = movies[indexPath.row]
            cellMovie.movies = movies
            cellMovie.configure()
            
            return cellMovie
            
        } else /*if collectionView == cinemasCollectionView*/{
            guard let cellCinema=collectionView.dequeueReusableCell(withReuseIdentifier: "cellCinema", for: indexPath) as? CinemaCollectionViewCell else { return UICollectionViewCell()}
            cellCinema.cinema = cinemas[indexPath.row]
            cellCinema.cinemas = cinemas
            cellCinema.configure()
            return cellCinema
        }

    }
    
    
}











