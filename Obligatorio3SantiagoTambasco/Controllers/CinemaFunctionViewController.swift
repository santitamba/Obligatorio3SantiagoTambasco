//
//  CinemaFunctionViewController.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 25/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit
import Firebase

class CinemaFunctionViewController: UIViewController {

    @IBOutlet weak var cinemaImage: UIImageView!
    @IBOutlet weak var CinemaFuncTableView: UITableView!
    
    var db: Firestore!
    var cinema = Cinema()
    var cinemas = [Cinema]()
    var movie = Movie()
    var movies = SessionManager.movies
    var function = Function()
    var funEmpty = Function()
    var functions = SessionManager.functions
    var functionMovie = [Function]()
    var functionCinema = [Function]()
    var sections:[String] = []
    var cell = [[Function]]()
    var avengers = [Function]()
    var spiderman = [Function]()
    var aladin = [Function]()
    var anabel = [Function]()
    var other = [Function]()
    var functionsForSegue = Function()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        addItemToSection()
        setImage()
        setFunctions()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setImage(){
        if let photoUrl = cinema.photoUrl {
            let url = URL(string: photoUrl)
            cinemaImage.kf.setImage(with: url)
        }
    }
    
    func addItemToSection(){
        for movie in movies{
            //Unrawapeo por que si no hay cine no tiene sentido comprar entradas, siempre hay cines
            sections.append(movie.title!)
        }
    }
    
    //Agrego las funciones del cine que pasa la pantalla anterior
    /*func setFunctions(){
        functionCinema = functions.filter({$0.cineId == cinema.id})
        for f in functionCinema{
            print (f.id)
            switch f.cineId!{
            case 1:
                self.aladin.append(f)
            case 2:
                self.avengers.append(f)
            case 3:
                self.spiderman.append(f)
            default:
                self.other.append(f)
            }
        }
        self.cell.append(self.aladin)
        self.cell.append(self.avengers)
        self.cell.append(self.spiderman)
        self.cell.append(self.other)
        
        self.CinemaFuncTableView.reloadData()
    }*/
    func setFunctions(){
        //functionMovie = functions.filter({$0.movieId == movie.id})
        //for f in functionMovie{
        functionCinema = functions.filter({$0.cineId == cinema.id})
        for f in functionCinema{
            print (f.id)
            switch f.movieId!{
            case 1:
                self.spiderman.append(f)
            case 2:
                self.avengers.append(f)
            case 3:
                 self.aladin.append(f)
            case 4:
                self.anabel.append(f)
            default:
                self.other.append(f)
            }
        }
        
        funEmpty.cineId = 0
        funEmpty.id = 0
        funEmpty.movieId = 0
        funEmpty.roomId = 0
        funEmpty.schedule = "No tenemos funcion para esta pelicula"
        
        if spiderman.isEmpty{
            self.spiderman.append(funEmpty)
        }
        if avengers.isEmpty{
            self.avengers.append(funEmpty)
        }
        if aladin.isEmpty{
            self.aladin.append(funEmpty)
        }
        if anabel.isEmpty{
            self.anabel.append(funEmpty)
        }
        
        self.cell.append(self.anabel)
        self.cell.append(self.aladin)
        self.cell.append(self.spiderman)
        self.cell.append(self.avengers)
        self.cell.append(self.other)
        
        self.CinemaFuncTableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RoomViewSegue1" {
            if let destinationVC = segue.destination as? RoomViewController {
                destinationVC.function = functionsForSegue
            }
        }
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

extension CinemaFunctionViewController: UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout{
    
    //Sections
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.sections[section]
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int{
        return(sections.count)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.darkGray
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    //Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = CinemaFuncTableView.cellForRow(at: indexPath) as! CinemaFuncitonTableViewCell
        
        functionsForSegue = cell.fun
        if functionsForSegue.movieId != 0 {
            self.performSegue(withIdentifier: "RoomViewSegue1", sender: self)
        }
        else{
            return
        }
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cell.count==0{
            return 0
        }
        else{
            return cell[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellCinFunction = tableView.dequeueReusableCell(withIdentifier: "cellCinFunction", for: indexPath) as! CinemaFuncitonTableViewCell
        
        cellCinFunction.functions=functions
        let fun = cell[indexPath.section][indexPath.row]
        cellCinFunction.fun = fun
        if fun.cineId == 0{
            cellCinFunction.configureEmptyCell()
        }
        else{
            cellCinFunction.configureCell()
        }


        
        return cellCinFunction
    }
    
}
