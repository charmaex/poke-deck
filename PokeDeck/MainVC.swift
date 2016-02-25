//
//  ViewController.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 24.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var appView: AppView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showApp:", name: "introDone", object: nil)

    }
    
    func showApp(notif: NSNotification) {
        appView.show()
    }

}

