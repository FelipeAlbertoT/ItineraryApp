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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cardView.addShadowAndRoundedCorners()
        
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 32)
        cardView.backgroundColor = Theme.accent
    }

    func setup(tripModel: TripModel) {
        titleLabel.text = tripModel.title
    }
}
