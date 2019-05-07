//
//  TableViewController.swift
//  CoreDataDemo
//
//  Created by JETS Mobile Lab - 8 on 5/7/19.
//  Copyright © 2019 ITI. All rights reserved.
//

import UIKit
import CoreData
class TableViewController: UITableViewController {
    var movies=Array<NSManagedObject>()
    var count=1
    @IBAction func addMovie(_ sender: UIBarButtonItem) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managerContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managerContext)
        let movie = NSManagedObject(entity: entity!, insertInto: managerContext)
        movie.setValue("Movie\(count)", forKey: "title")
        movie.setValue(5.8, forKey: "rate")
        movie.setValue(2000, forKey: "releaseDate")
        //movies.append(MovieClass(title: "movie\(count)", releaseData: 2000, rate: 5.5))
        count+=1
        do{
            try managerContext.save()
            movies.append(movie)
            self.tableView.reloadData()
        }catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // var movie1 = MovieClass(title: "movie 1", releaseData: 2000, rate: 5.0)
        // var movie2 = MovieClass(title: "movie 2", releaseData: 2010, rate: 6)
        // var movie3 = MovieClass(title: "movie 3", releaseData: 2020, rate: 5.7)
        // movies.append(movie1)
        // movies.append(movie2)
        // movies.append(movie3)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //3ayz a3rd l 7agat l bdefha f l core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managerContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"Movie")
        do{
            movies = try managerContext.fetch(fetchRequest)
        }catch{
            
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = movies[indexPath.row].value(forKey: "title") as! String
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
         // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managerContext = appDelegate.persistentContainer.viewContext
        managerContext.delete(movies[indexPath.row])
        movies.remove(at: indexPath.row)
        do{
            try managerContext.save()
        }
        catch{
            print("error")
        }
      //elstr da lazm ykon t7t 
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
