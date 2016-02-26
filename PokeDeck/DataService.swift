//
//  SaveService.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 26.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import Foundation

class DataService {
    static let inst = DataService()
    
    private var _opened: Int!
    private let ANIMATE_UNTIL = 3
    
    var animateMusic: Bool {
        guard let opened = _opened else {
            return true
        }
        return opened <= ANIMATE_UNTIL
    }
    
    init() {
        load()
        if _opened <= ANIMATE_UNTIL + 1 {
            save()
            print("hh2")
        }
    }
    
    private func load() {
        guard let opened = NSUserDefaults.standardUserDefaults().objectForKey("openedCount") as? Int else {
            _opened = 1
            return
        }
        
        _opened = opened + 1
    }
    
    private func save() {
        NSUserDefaults.standardUserDefaults().setObject(_opened, forKey: "openedCount")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}