//
//  TripsTableViewCell.swift
//  Itinerary
//
//  Created by Felipe Treichel on 18/09/2018.
//  Copyright © 2018 Felipe Treichel. All rights reserved.
//

import UIKit

class TripsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tripImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cardView.addShadowAndRoundedCorners()
        
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 32)
        cardView.backgroundColor = Theme.accent
        
        titleLabel.layer.shadowOpacity = 1
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOffset = CGSize.zero
        titleLabel.layer.shadowRadius = 5
        
        tripImageView.layer.cornerRadius = cardView.layer.cornerRadius
    }
    
    func setup(tripModel: TripModel) {
        titleLabel.text = tripModel.title
        
        if let tripImage = tripModel.image {
            tripImageView.alpha = 0.3
            tripImageView.image = tripImage
            
            UIView.animate(withDuration: 1) {
                self.tripImageView.alpha = 1
            }
        }
    }
}
