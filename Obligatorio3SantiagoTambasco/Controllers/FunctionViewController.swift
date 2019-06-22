//
//  FunctionViewController.swift
//  Obligatorio3SantiagoTambasco
//
//  Created by Adrian Perez Garrone on 17/6/19.
//  Copyright © 2019 Adrian Perez Garrone. All rights reserved.
//

import UIKit
import Firebase

class FunctionViewController: UIViewController {

    @IBOutlet weak var functionsTableView: UITableView!
    @IBOutlet weak var imageMovie: UIImageView!
   
    var db: Firestore!
    var cinema = Cinema()
    var cinemas = [Cinema]()
    var movie = Movie()
    var function = Function()
    var functions = SessionManager.functions
    var functionMovie = [Function]()
    var sections:[String] = []
    var cell = [[Function]]()
    var portones = [Function]()
    var montevideo = [Function]()
    var tresCruces = [Function]()
    var nuevoCentro = [Function]()
    var other = [Function]()
    var functionsForSegue = Function()
    
    func setImage(){
        if let photoUrl = movie.photoUrl {
            let url = URL(string: photoUrl)
            imageMovie.kf.setImage(with: url)
        }
    }    
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // [START setup]
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        addItemToSection()
        setImage()
        //getFunctions()
        setFunctions()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addItemToSection(){
        for cine in cinemas{
            //Unrawapeo por que si no hay cine no tiene sentido comprar entradas, siempre hay cines
            sections.append(cine.name!)
        }
    }
    
    //Agrego las funciones de la pelicula que pasa la pantalla anterior
    func setFunctions(){
        functionMovie = functions.filter({$0.movieId == movie.id})
        for f in functionMovie{
            print (f.id)
            switch f.cineId!{
            case 1:
                self.portones.append(f)
            case 2:
                self.tresCruces.append(f)
            case 4:
                self.nuevoCentro.append(f)
            case 3:
                self.montevideo.append(f)
            default:
                self.other.append(f)
            }
            }
        self.cell.append(self.tresCruces)
        self.cell.append(self.nuevoCentro)
        self.cell.append(self.montevideo)
        self.cell.append(self.portones)
        self.cell.append(self.other)
        
        self.functionsTableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RoomViewSegue" {
            if let destinationVC = segue.destination as? RoomViewController {
                destinationVC.function = functionsForSegue
            }
        }
    }
    
    
    //Agrego una lista de listas que sea [[cine:funcitons],[cine:functions]]

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FunctionViewController: UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegateFlowLayout{
    
    //Sections
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.sections[section]
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int{
        return(sections.count)
    }
    
    
    //Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        functionsForSegue = functions[indexPath.row]
        self.performSegue(withIdentifier: "RoomViewSegue", sender: self)
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
        let cellFunction = tableView.dequeueReusableCell(withIdentifier: "cellFunction", for: indexPath) as! FunctionCollectionViewCell
        
        cellFunction.functions=functions
        let fun = cell[indexPath.section][indexPath.row]
        cellFunction.fun = fun
        cellFunction.configureCell()
        //cellFunction.delegate = self
        //cellFunction.indexPath = indexPath
        //cellFunction.purchase = purchases[indexPath.row]
        //cellFunction.configureCell()
        
        return cellFunction
    }
    
    
    
    
}
