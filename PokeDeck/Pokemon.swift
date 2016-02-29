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
    
    private var _downloaded = false
    
    private var _bio: String!
    private var _defense: String!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _evoTo: String!
    private var _evoLvl: Int!
    private var _evoId: String!
    private var _abilities = [String]()
    private var _moves = [String]()
    
    var name: String {
        return _name.capitalizedString
    }
    
    var id: String {
        return "\(_id)"
    }
    
    var bio: String {
        return _bio == nil ? "" : _bio
    }
    
    var defense: String {
        return _defense == nil ? "" : _defense
    }
    
    var type: String {
        return _type == nil ? "" : _type.capitalizedString
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
        guard _evoTo != nil else {
            return "No evolution"
        }
        var x = "Evolves to \(_evoTo)"
        if _evoLvl != nil {
            x += " at Level \(_evoLvl)"
        }
        return x
    }
    
    var abilities: String {
        var x = ""
        for (i, ability) in _abilities.enumerate() {
            x += i > 0 ? "\n" : ""
            x += "\(ability.capitalizedString)"
        }
        
        return x
    }
    
    var moves: String {
        var x = ""
        for (i, moves) in _moves.enumerate() {
            x += i > 0 ? ", " : ""
            x += "\(moves.capitalizedString)"
        }
        
        return x
    }
    
    var image: UIImage? {
        return UIImage(named: "\(_id)")
    }
    
    var evoImage: UIImage? {
        guard let x = _evoId else {
            return nil
        }
        return UIImage(named: x)
    }
    
    init(name: String, id: Int) {
        _name = name
        _id = id
    }
    
    func downloadData(completed: DownloadCompleted) {
        guard !_downloaded else {
            return completed()
        }
        
        let url = NSURL(string: "\(API_BASE_URL)\(API_POKE_URL)/\(_id)/")!
        
        Alamofire.request(.GET, url).responseJSON { (response: Response<AnyObject, NSError>) -> Void in
            guard let result = response.result.value as? [String: AnyObject] else {
                return completed()
            }
            
            if let weight = result["weight"] as? String {
                self._weight = weight
            }
            
            if let height = result["height"] as? String {
                self._height = height
            }
            
            if let defense = result["defense"] as? Int {
                self._defense = "\(defense)"
            }
            
            if let attack = result["attack"] as? Int {
                self._attack = "\(attack)"
            }
            
            if let types = result["types"] as? [Dictionary<String, String>] where types.count > 0 {
                var typeStr = ""
                for (i, type) in types.enumerate() {
                    guard let name = type["name"] else {
                        continue
                    }
                    
                    typeStr += i > 0 ? " / " : ""
                    typeStr += name
                }
                self._type = typeStr
            }
            
            if let abilities = result["abilities"] as? [Dictionary<String, String>] where abilities.count > 0 {
                for ab in abilities {
                    guard let ability = ab["name"] else {
                        continue
                    }
                    self._abilities.append(ability)
                }
            }
            
            if let moves = result["moves"] as? [Dictionary<String, AnyObject>] where moves.count > 0 {
                for mo in moves {
                    guard let move = mo["name"] as? String else {
                        continue
                    }
                    self._moves.append(move)
                }
            }
            
            if let evolution = result["evolutions"] as? [Dictionary<String, AnyObject>] where evolution.count > 0 {
                let evo = evolution[0]
                
                if let lvl = evo["level"] as? Int {
                    self._evoLvl = lvl
                }
                if let to = evo["to"] as? String {
                    self._evoTo = to
                }
                
                if let evoUrl = evo["resource_uri"] as? String {
                    let newStr = evoUrl.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                    let id = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                    if let idInt = Int(id) {
                        if idInt <= PokemonService.inst.dataList.count {
                            self._evoId = id
                        }
                    }
                }
            }
            
            if let desc = result["descriptions"] as? [Dictionary<String, String>] where desc.count > 0 {
                if let descUrl = desc[0]["resource_uri"] {
                    let url = NSURL(string: "\(API_BASE_URL)\(descUrl)")!
                    Alamofire.request(.GET, url).responseJSON(completionHandler: { response -> Void in
                        guard let result = response.result.value as? [String: AnyObject] else {
                            return completed()
                        }
                        
                        if let description = result["description"] as? String {
                            self._bio = description
                        }
                        
                        completed()
                    })
                }
            }
            
            self._downloaded = true
            completed()
        }
        
    }
}
