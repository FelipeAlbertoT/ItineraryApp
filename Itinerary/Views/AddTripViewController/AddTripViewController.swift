//
//  AddTripViewController.swift
//  Itinerary
//
//  Created by Felipe Treichel on 19/09/2018.
//  Copyright © 2018 Felipe Treichel. All rights reserved.
//

import UIKit
import Photos

class AddTripViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tripTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var doneSaving: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 24)
        titleLabel.layer.shadowOpacity = 1
        titleLabel.layer.shadowColor = UIColor.white.cgColor
        titleLabel.layer.shadowOffset = CGSize.zero
        titleLabel.layer.shadowRadius = 5
        
        imageView.layer.cornerRadius = 10
        
    }

    @IBAction func save(_ sender: Any) {
        tripTextField.rightViewMode = .never
        
        guard tripTextField.text != "", let title = tripTextField.text else {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
            imageView.image = "⚠️".image()
            imageView.contentMode = .scaleAspectFit
            
            tripTextField.rightView = imageView
            tripTextField.rightViewMode = .always
            return
        }
        
        TripFunctions.createTrip(tripModel: TripModel(title: title, image: imageView.image))
        
        doneSaving?()
        dismiss(animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    fileprivate func presentPhotoLibrary() {
        let myPickerControler = UIImagePickerController()
        myPickerControler.delegate = self
        myPickerControler.sourceType = .photoLibrary
        self.present(myPickerControler, animated: true, completion: nil)
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    self.presentPhotoLibrary()
                case .notDetermined:
                    if status == PHAuthorizationStatus.authorized {
                        self.presentPhotoLibrary()
                    }
                case .restricted:
                    let alert = UIAlertController(title: "Photo Library Restricted", message: "Photo Library access is restricted and cannot be accessed.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(okAction)
                    self.present(alert, animated: true)
                case .denied:
                    let alert = UIAlertController(title: "Photo Library Access Denied", message: "Photo Library access was previously denied. Please update your settings if you wish to change this.", preferredStyle: .alert)
                    let goToSettingsAction = UIAlertAction(title: "Go to Settings", style: .default) { (action) in
                        DispatchQueue.main.async {
                            let url = URL(string: UIApplicationOpenSettingsURLString)!
                            UIApplication.shared.open(url, options: [String : Any]())
                        }
                    }
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                    alert.addAction(goToSettingsAction)
                    alert.addAction(cancelAction)
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
}

extension AddTripViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = image
        }
        
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
