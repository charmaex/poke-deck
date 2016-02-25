//
//  IntroImage.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 25.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import UIKit

class IntroImage: UIImageView {

    override func awakeFromNib() {
        let animationTime: NSTimeInterval = 1
        
        var images = [UIImage]()
        
        for i in 0...15 {
            images.append(UIImage(named: "Intro\(i)")!)
        }
        
        image = UIImage(named: "Intro15")
        
        animationImages = images
        animationDuration = animationTime
        animationRepeatCount = 1
        startAnimating()
        
        let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(animationTime * Double(NSEC_PER_SEC)))
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            self.introDone()
            UIView.animateWithDuration(animationTime, animations: {
                
                self.alpha = 0
                }, completion: {
                    (value: Bool) in
                    self.hidden = value
                    self.alpha = 1
            })
        })
    }
    
    func introDone() {
        NSNotificationCenter.defaultCenter().postNotificationName("introDone", object: nil)
    }

}
