//
//  AddTripViewController.swift
//  Itinerary
//
//  Created by Felipe Treichel on 19/09/2018.
//  Copyright © 2018 Felipe Treichel. All rights reserved.
//

import UIKit

class AddTripViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tripTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var doneSaving: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 24)
    }

    @IBAction func save(_ sender: Any) {
        if let title = tripTextField.text {
            TripFunctions.createTrip(tripModel: TripModel(title: title))
            
            doneSaving?()
            dismiss(animated: true)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    

}
