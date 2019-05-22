//
//  ViewController.swift
//  PetTrips
//
//  Created by Alevtina on 22/05/2019.
//  Copyright © 2019 Alevtina. All rights reserved.
//

import UIKit

class TripNameViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDestinations" {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            if let tripName = nameTextField.text {
                if let destinationVC = segue.destination as? DestinationsTableViewController {
                    let trip = Trip(context: context)
                    trip.name = tripName
                    trip.id = UUID().uuidString
                    destinationVC.tripId = trip.id ?? ""
                    
                    do {
                        try context.save()
                        print("Saved trip: \(trip.name ?? "") \(trip.id ?? "")")
                    } catch let error {
                        print("Could not save trip: \(error)")
                    }
                }
            } else {
                let alert = UIAlertController(
                    title: "Empty name",
                    message: "Please, enter the name of the trip",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: { (action) in
                        self.dismiss(animated: true, completion: nil)
                }))
                alert.addAction(UIAlertAction(
                    title: "Ignore",
                    style: .destructive,
                    handler: { (action) in
                        if let destinationVC = segue.destination as? DestinationsTableViewController {
                            let trip = Trip(context: context)
                            trip.name = "Unnamed"
                            trip.id = UUID().uuidString
                            destinationVC.tripId = trip.id ?? ""
                            
                            do {
                                try context.save()
                                print("Saved trip: \(trip.name ?? "") \(trip.id ?? "")")
                            } catch let error {
                                print("Could not save trip: \(error)")
                            }
                        }
                }))
            }
        }
    }


}

