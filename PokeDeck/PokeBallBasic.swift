//
//  PressButton.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 25.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import UIKit

class PokeBallBasic: UIImageView {

    private var _timer: NSTimer!
    private var _originalPosition: CGPoint!
    private var _originalFrame: CGRect!
    
    private var _tapSuccessful = false
    var tapSuccessful: Bool {
        return _tapSuccessful
    }
    
    private let DEFAULT_IMG_NAME = "PokeBall3"
    private let TIMER_INTERVAL: NSTimeInterval = 15
    
    override func awakeFromNib() {
        userInteractionEnabled = true
        
        var animImages = [UIImage]()
        
        
        var x = [Int]()
        x += Array(3.stride(to: -1, by: -1))
        x += Array(1...5)
        x.append(4)
        
        for i in x {
            animImages.append(UIImage(named: "PokeBall\(i)")!)
        }
        
        animationImages = animImages
        animationRepeatCount = -1
        animationDuration = 1.2
        
        if DataService.inst.animatePokeBall {
            startTimer()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        _originalPosition = center
        _originalFrame = frame
        
        let xRescale: CGFloat = 8
        let yRescale: CGFloat = 8
        
        let x = _originalPosition.x - (bounds.height - xRescale) / 2
        let y = _originalPosition.y - (bounds.width  - yRescale) / 2
        let frameNew = CGRectMake(x, y, bounds.width - xRescale, bounds.height - yRescale)
        frame = frameNew
        
        stopAnimating()
        
        cancelTimer()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        frame = _originalFrame
        center = _originalPosition
        
        image = UIImage(named: DEFAULT_IMG_NAME)
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.locationInView(super.superview?.superview)
        
        _tapSuccessful = frame.contains(location)
    }
    
    func startTimer() {
        _timer = NSTimer.scheduledTimerWithTimeInterval(TIMER_INTERVAL, target: self, selector: "startAnimating", userInfo: nil, repeats: false)
    }
    
    private func cancelTimer() {
        guard let timer = _timer else {
            return
        }
        
        timer.invalidate()
    }

}
