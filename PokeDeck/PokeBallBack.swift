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
    
    override func tapped() {
        guard let delegate = delegate as? DetailVC else {
            self.delegate?.dismissViewControllerAnimated(true, completion: nil)
            return
        }
        
        delegate.closeAnimation({
            delegate.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
}
