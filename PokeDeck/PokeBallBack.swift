//
//  PokeBallBack.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 28.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import Foundation
import UIKit

class PokeBallBack: PokeBallBasic {
    
    var delegate: UIViewController!
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        
        if tapSuccessful {
            guard let delegate = delegate as? DetailVC else {
                self.delegate.dismissViewControllerAnimated(true, completion: nil)
                return
            }
            
            delegate.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
}
