//
//  Pokemon.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 25.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import Foundation
import UIKit

class Pokemon {
    
    private var _name: String
    private var _id: Int
    
    private var _bio: String!
    private var _defense: String!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: String!
    private var _evoLabel: String!
    
    var name: String {
        return _name
    }
    
    var id: Int {
        return _id
    }
    
    var image: UIImage? {
        return UIImage(named: "\(_id)")
    }
    
    init(name: String, id: Int) {
        _name = name
        _id = id
    }
    
    func downloadData(completed: DownloadCompleted) {
        
    }
}