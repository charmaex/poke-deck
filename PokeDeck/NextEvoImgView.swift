//
//  NextEvoImgView.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 01.03.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import Foundation
import UIKit

class NextEvoImgView: TappableImage {

    override func tapped() {
        guard let delegate = delegate as? DetailVC else {
            return
        }
        
        delegate.evoPokemon()
    }
    
}
