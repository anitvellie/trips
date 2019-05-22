//
//  DestinationInfoViewController.swift
//  PetTrips
//
//  Created by Alevtina on 22/05/2019.
//  Copyright © 2019 Alevtina. All rights reserved.
//

import UIKit
import CoreData

class DestinationInfoViewController: UIViewController {
    
    var tripId: String?
    var tripFetched: Trip?
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveDestination(_ sender: UIBarButtonItem) {
        if let cityName = cityTextField.text {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = Trip.fetchRequest() as NSFetchRequest<Trip>
            if let id = tripId {
                fetchRequest.predicate = NSPredicate(format: "id == %@", id)
                print("Trip id: \(id)")
            }
            
            do {
                tripFetched = try context.fetch(fetchRequest).first
                let destination = Destination(context: context)
                destination.cityName = cityName
                destination.id = UUID().uuidString
                destination.dateArrival = Date()
                destination.dateDeparture = Date()
                tripFetched?.addToDestinations(destination)
                
                do {
                    try context.save()
                    print("Saved destination to \(cityName)")
                } catch let error {
                    print("Could not save trip with destinations: \(error)")
                }
                
            } catch let error {
                print("Could not fetch trip: \(error)")
            }
            
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(
                title: "Empty city",
                message: "Please, enter the name of the city.",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: { (action) in
                    self.dismiss(animated: true, completion: nil)
            }))
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
