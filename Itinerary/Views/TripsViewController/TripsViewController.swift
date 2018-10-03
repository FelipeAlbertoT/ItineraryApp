//
//  TripsViewController.swift
//  Itinerary
//
//  Created by Felipe Treichel on 18/09/2018.
//  Copyright © 2018 Felipe Treichel. All rights reserved.
//

import UIKit

class TripsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var helpView: UIVisualEffectView!
    
    var tripIndexToEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.backgroundColor
        addButton.createFloatingActionButton()
        
        TripFunctions.readTrips { [unowned self] in
            self.tableView.reloadData()
            
            if Data.tripModels.count > 0 {
                if !UserDefaults.standard.bool(forKey: "seenTripHelp"){
                    self.view.addSubview(self.helpView)
                    self.helpView.frame = self.view.frame
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTripSegue" {
            let popup = segue.destination as! AddTripViewController
            popup.tripIndexToEdit = self.tripIndexToEdit
            popup.doneSaving = { [weak self] in
                self?.tableView.reloadData()
            }
            tripIndexToEdit = nil
        }
    }
    
    @IBAction func closeHelpView(_ sender: AppUIButton) {
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.helpView.alpha = 0
        }) { (_) in
            self.helpView.removeFromSuperview()
            UserDefaults.standard.set(true, forKey: "seenTripHelp")
        }
    }
}

extension TripsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.tripModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TripsTableViewCell
        cell.setup(tripModel: Data.tripModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: (Bool)->()) in
            self.tripIndexToEdit = indexPath.row
            self.performSegue(withIdentifier: "toAddTripSegue", sender: nil)
            actionPerformed(true)
        }
        
        edit.image = UIGraphicsImageRenderer(size:CGSize(width: 35, height: 35)).image { _ in
            UIImage(named:"edit")?.draw(in: CGRect(x: 0, y: 0, width: 35, height: 35))
        }
        edit.backgroundColor = UIColor(named: "Edit")
        
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: @escaping (Bool) -> ()) in
            
            let alert = UIAlertController(title: "Delete Trip", message: "Are you sure you want to delete this trip?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { (alertAction) in
                actionPerformed(false)
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alertAction) in
                TripFunctions.deleteTrip(index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                actionPerformed(true)
            }))
            
            self.present(alert, animated: true)
        }
        
        delete.image = UIGraphicsImageRenderer(size:CGSize(width: 35, height: 35)).image { _ in
            UIImage(named:"trash")?.draw(in: CGRect(x: 0, y: 0, width: 35, height: 35))
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}
