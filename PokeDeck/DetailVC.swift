//
//  DetailVC.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 28.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var backPokeBall: PokeBallBack!
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var bioLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var evoImg: UIImageView!
    @IBOutlet weak var evoNextImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backPokeBall.delegate = self
        
        nameLbl.text = pokemon.name.capitalizedString
        mainImg.image = pokemon.image
        evoImg.image = pokemon.image
        
        pokemon.downloadData { () -> () in
            self.bioLbl.text = self.pokemon.bio
            self.typeLbl.text = self.pokemon.type
            self.defenseLbl.text = self.pokemon.defense
            self.heightLbl.text = self.pokemon.height
            self.attackLbl.text = self.pokemon.attack
            self.weightLbl.text = self.pokemon.weight
            self.evoLbl.text = self.pokemon.evolution
            self.evoNextImg.image = self.pokemon.evoImage
        }
        
    }

}
