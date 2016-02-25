//
//  PokemonCVCell.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 25.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbL: UILabel!
    
    private var _pokemon: Pokemon!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = bounds.width * 0.1
    }
    
    func initializeCell(pokemon: Pokemon) {
        _pokemon = pokemon
        
        nameLbL.text = pokemon.name.uppercaseString
        imgView.image = pokemon.image
    }

}
