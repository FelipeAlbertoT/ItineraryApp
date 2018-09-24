//
//  RoundedImageView.swift
//  Itinerary
//
//  Created by Felipe Treichel on 21/09/2018.
//  Copyright © 2018 Felipe Treichel. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedImageView: UIImageView {

    @IBInspectable public var cornerRadius: CGFloat = 10.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
