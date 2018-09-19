//
//  TripModel.swift
//  Itinerary
//
//  Created by Felipe Treichel on 17/09/2018.
//  Copyright © 2018 Felipe Treichel. All rights reserved.
//

import UIKit

class TripModel {
    
    let id: UUID
    var title: String
    var image: UIImage?
    
    init(title: String, image: UIImage? = nil) {
        id = UUID()
        self.title = title
        self.image = image
    }
}
