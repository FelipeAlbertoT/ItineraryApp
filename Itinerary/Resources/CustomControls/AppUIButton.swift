//
//  AppUIButton.swift
//  Itinerary
//
//  Created by Felipe Treichel on 19/09/2018.
//  Copyright © 2018 Felipe Treichel. All rights reserved.
//

import UIKit

class AppUIButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = Theme.tintColor
        layer.cornerRadius = frame.height / 2
        
        setTitleColor(UIColor.white, for: .normal)
    }
}
