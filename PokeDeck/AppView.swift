//
//  AppView.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 25.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import UIKit

class AppView: UIView {

    override func awakeFromNib() {
        hidden = true
    }
    
    func show() {
        alpha = 0
        hidden = false
        UIView.animateWithDuration(1) { () -> Void in
            self.alpha = 1
        }
    }

}
