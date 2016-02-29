//
//  MoveView.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 29.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func move(newCenter: CGPoint, time: Double) {
        UIView.animateWithDuration(time) { () -> Void in
            self.center = newCenter
        }
    }
    
    func fadeIn(time: Double) {
        UIView.animateWithDuration(time) { () -> Void in
            self.alpha = 1
        }
    }
    
    func fadeOut(time: Double) {
        UIView.animateWithDuration(time) { () -> Void in
            self.alpha = 0
        }
    }
    
}
