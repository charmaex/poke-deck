//
//  Pokemon.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 25.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Pokemon {
    
    private var _name: String
    private var _id: Int
    
    private var _bio: String!
    private var _defense: String!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _evolution: String!
    private var _evoId: Int!
    
    var name: String {
        return _name
    }
    
    var id: Int {
        return _id
    }
    
    var bio: String {
        return _bio == nil ? "" : _bio
    }
    
    var defense: String {
        return _defense == nil ? "" : _defense
    }
    
    var type: String {
        return _type == nil ? "" : _type
    }
    
    var height: String {
        return _height == nil ? "" : _height
    }
    
    var weight: String {
        return _weight == nil ? "" : _weight
    }
    
    var attack: String {
        return _attack == nil ? "" : _attack
    }
    
    var evolution: String {
        return _evolution == nil ? "" : _evolution
    }
    
    var image: UIImage? {
        return UIImage(named: "\(_id)")
    }
    
    var evoImage: UIImage? {
        return UIImage(named: "\(_evoId)")
    }
    
    init(name: String, id: Int) {
        _name = name
        _id = id
    }
    
    func downloadData(completed: DownloadCompleted) {
        let url = NSURL(string: "\(API_BASE_URL)/\(API_POKE_URL)/\(_id)/")!
        
        Alamofire.request(.GET, url).responseJSON { (response: Response<AnyObject, NSError>) -> Void in
            guard let result = response.result.value as? [String: AnyObject] else {
                return
            }
            
            if let weight = result["weight"] as? Int {
                self._weight = "\(weight)"
            }
            
            
            completed()
        }
        
    }
}
