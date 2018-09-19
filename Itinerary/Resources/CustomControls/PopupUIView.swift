//
//  PopupUIView.swift
//  Itinerary
//
//  Created by Felipe Treichel on 19/09/2018.
//  Copyright © 2018 Felipe Treichel. All rights reserved.
//

import UIKit

class PopupUIView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 10
        
        backgroundColor = Theme.backgroundColor
    }

}
