//
//  TappableImage.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 01.03.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import Foundation
import UIKit

class TappableImage: UIImageView {
    var delegate: UIViewController?
    
    private var _originalPosition: CGPoint!
    private var _originalFrame: CGRect!
    
    private var _tapSuccessful = false
    var tapSuccessful: Bool {
        return _tapSuccessful
    }
    
    override func awakeFromNib() {
        userInteractionEnabled = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        _originalPosition = center
        _originalFrame = layer.frame
        
        let xRescale: CGFloat = 8
        let yRescale: CGFloat = 8
        
        let x = _originalPosition.x - (bounds.height - xRescale) / 2
        let y = _originalPosition.y - (bounds.width  - yRescale) / 2
        let frameNew = CGRectMake(x, y, bounds.width - xRescale, bounds.height - yRescale)
        layer.frame = frameNew
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        layer.frame = _originalFrame
        center = _originalPosition
        
        guard let touch = touches.first else {
            _tapSuccessful = false
            return
        }
        
        let location = touch.locationInView(super.superview?.superview)
        
        _tapSuccessful = frame.contains(location)
        
        if tapSuccessful {
            tapped()
        }
    }
    
    func tapped() {
        
    }
}
