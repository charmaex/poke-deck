//
//  PokeBallMusic.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 28.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import Foundation
import UIKit

class PokeBallMusic: PokeBallBasic {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
        if AudioService.inst.playingMusic {
            image = UIImage(named: "PokeBallAudioOff")
        } else {
            image = UIImage(named: "PokeBallAudioOn")
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        
        if tapSuccessful {
            AudioService.inst.toggleAudio()
        }
    }
}
