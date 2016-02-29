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
    @IBOutlet weak var bioAbilSeg: UISegmentedControl!
    
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
        
        nameLbl.text = pokemon.name
        idLbl.text = pokemon.id
        mainImg.image = pokemon.image
        evoImg.image = pokemon.image
        evoNextImg.hidden = true
        
        pokemon.downloadData { () -> () in
            self.updatedData()
        }
        
    }
    
    func updatedData() {
        updateBioAbil()
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        attackLbl.text = pokemon.attack
        weightLbl.text = pokemon.weight
        evoLbl.text = pokemon.evolution
        if pokemon.evoImage != nil {
            evoNextImg.image = pokemon.evoImage
            evoNextImg.hidden = false
        }
    }
    
    func updateBioAbil() {
        switch bioAbilSeg.selectedSegmentIndex {
        case 0: bioLbl.text = pokemon.bio
        case 1: bioLbl.text = pokemon.abilities
        case 2: bioLbl.text = pokemon.moves
        default: bioLbl.text = ""
        }
    }
    
    @IBAction func bioAbilChanged(sender: AnyObject) {
        updateBioAbil()
    }

}
