//
//  DestinationsTableViewController.swift
//  PetTrips
//
//  Created by Alevtina on 22/05/2019.
//  Copyright © 2019 Alevtina. All rights reserved.
//

import UIKit
import CoreData

class DestinationsTableViewController: UITableViewController {
    
    var tripName: String?
    var tripId: String?
    var tripFetched: Trip?
    var destinations = [Destination]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = Trip.fetchRequest() as NSFetchRequest<Trip>
        if let id = tripId {
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            print("Trip id: \(id)")
        }
        
        do {
            tripFetched = try context.fetch(fetchRequest).first
            guard let trip = tripFetched,
                let fetchedDestinations = trip.destinations,
                let arrayOfDestinations = Array(fetchedDestinations) as? [Destination] else {
                print("Could not get destinations.")
                return
            }
            self.title = trip.name
            destinations = arrayOfDestinations
            tableView.reloadData()
            
        } catch let error {
            print("Could not fetch trip: \(error)")
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = Trip.fetchRequest() as NSFetchRequest<Trip>
        if let id = tripId {
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            print("Trip id: \(id)")
        }
        
        do {
            tripFetched = try context.fetch(fetchRequest).first
            guard let trip = tripFetched,
                let fetchedDestinations = trip.destinations,
                let arrayOfDestinations = Array(fetchedDestinations) as? [Destination] else {
                    print("Could not get destinations.")
                    return
            }
            self.title = trip.name
            destinations = arrayOfDestinations
            tableView.reloadData()
            
        } catch let error {
            print("Could not fetch trip: \(error)")
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "destinationCell", for: indexPath)
        if let city = destinations[indexPath.row].cityName {
            cell.textLabel?.text = city
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addDestination" {
            if let destinationVC = segue.destination as? DestinationInfoViewController {
                if let id = tripId {
                    destinationVC.tripId = id
                }
            }
        }
    }

}
