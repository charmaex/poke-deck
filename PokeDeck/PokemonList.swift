//
//  PokemonService.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 25.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import Foundation

class PokemonList {
    static let inst = PokemonList()
    
    private var _dataList = [Pokemon]()
    
    var dataList: [Pokemon] {
        return _dataList
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

}