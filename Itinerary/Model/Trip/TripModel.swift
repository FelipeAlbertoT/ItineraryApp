//
//  TripModel.swift
//  Itinerary
//
//  Created by Felipe Treichel on 17/09/2018.
//  Copyright © 2018 Felipe Treichel. All rights reserved.
//

import Foundation

class TripModel {
    
    let id: UUID
    var title: String
    
    init(title: String) {
        id = UUID()
        self.title = title
    }
}
