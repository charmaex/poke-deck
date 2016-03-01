//
//  PressButton.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 25.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import UIKit

class PokeBallBasic: TappableImage {

    private var _timer: NSTimer!
    
    private let DEFAULT_IMG_NAME = "PokeBall3"
    private let TIMER_INTERVAL: NSTimeInterval = 15
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
        super.touchesBegan(touches, withEvent: event)
        
        stopAnimating()
        
        cancelTimer()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        
        let time: Double = tapSuccessful ? 1 : 0
        
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.image = UIImage(named: self.DEFAULT_IMG_NAME)
        })
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
