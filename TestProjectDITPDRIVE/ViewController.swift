//
//  ViewController.swift
//  TestProjectDITPDRIVE
//
//  Created by Kittitat Saengthong on 3/3/2560 BE.
//  Copyright © 2560 Kittitat Saengthong. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  var species: Array<Any>? = nil
  var numberOfSpecies = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    getSpecies()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func getSpecies() {
    let router = AlamofireRouter.getSpecies
    Alamofire.request(router).responseJSON { (response) in
      switch response.result {
      case .success(let value):
        if let jsonResult = value as? [String: Any] {
//          print("Json Result : \(jsonResult["results"])")
          
          self.species = jsonResult["results"] as! Array<Any>!
          self.numberOfSpecies = (self.species?.count)!
          
          self.tableView.reloadData()
        }
        
      case .failure(let error):
        print(error)
      }
    }
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numberOfSpecies
}

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    tableView.register(UINib(nibName: "SpeciesTableViewCell", bundle: nil), forCellReuseIdentifier: "SpeciesTableViewCell")
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "SpeciesTableViewCell") as! SpeciesTableViewCell
    
    if let specie = species?[indexPath.row] as? [String: Any] {
      print(specie)
      
      if let name = specie["name"] as? String {
        cell.nameLabel.text = name
      }
    }
    
    return cell
  }
}
