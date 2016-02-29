//
//  PokemonService.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 25.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import Foundation

class PokemonService {
    static let inst = PokemonService()
    
    private var _dataList = [Pokemon]()
    private var _filteredList = [Pokemon]()
    private var _filter = false
    private var _lastFilter = ""
    
    var dataList: [Pokemon] {
        return _filter ? _filteredList : _dataList
    }
    
    init() {
        let data = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
            let csvParser = try CsvParser(contentsOfURL: data)
            
            let rows = csvParser.rows
            
            for row in rows {
                let name = row["identifier"]!
                let id = Int(row["id"]!)!
                
                let pokemon = Pokemon(name: name, id: id)
                _dataList.append(pokemon)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func updateFilter(filter: String?) {
        let update = false == (filter == _lastFilter)
        
        if let filter = filter where filter != "" {
            _filter = true
            _lastFilter = filter
            if update {
                _filteredList = _dataList.filter( { $0.name.lowercaseString.rangeOfString(filter.lowercaseString) != nil } )
            }
        } else {
            _filter = false
            _lastFilter = ""
        }

        if update {
            NSNotificationCenter.defaultCenter().postNotificationName("reloadCollView", object: nil)
        }
    }

}
