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
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLbl: UILabel!
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
    @IBOutlet weak var evoNextImg: NextEvoImgView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backPokeBall.delegate = self
        evoNextImg.delegate = self
        
        titleLbl.alpha = 0
        topViewConstraint.constant = view.bounds.height / 2
        bottomViewConstraint.constant = view.bounds.height / 2
        
        initializeView()
    }
    
    func initializeView() {
        nameLbl.text = pokemon.name
        idLbl.text = pokemon.id
        mainImg.image = pokemon.image
        evoImg.image = pokemon.image
        evoNextImg.hidden = true
        
        pokemon.downloadData { () -> () in
            self.updatedData()
            
            let dispatchTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC)))
            dispatch_after(dispatchTime, dispatch_get_main_queue(), {
                self.openAnimation()
            })
        }
    }
    
    func openAnimation() {
        let time: Double = 0.3
        let delay: Double = 0.1
        
        topViewConstraint.constant = 60
        bottomViewConstraint.constant = 28
        
        UIView.animateWithDuration(time, delay: delay, options: [.CurveEaseOut], animations: { () -> Void in
            self.view.layoutIfNeeded()
            }) { (Bool) -> Void in
                self.titleLbl.fadeIn(time)
        }
    }
    
    func closeAnimation(completed: AfterAnimation) {
        let time: Double = 0.3
        let fadeOut: Double = 0.1
        
        let constant = view.bounds.height / 2
        topViewConstraint.constant = constant
        bottomViewConstraint.constant = constant
        
        titleLbl.fadeOut(fadeOut)
        
        UIView.animateWithDuration(time, delay: fadeOut, options: [.CurveEaseOut], animations: { () -> Void in
            self.view.layoutIfNeeded()
            }) { (Bool) -> Void in
                completed()
        }
    }
    
    func updatedData() {
        updateBioAbilLbl()
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
    
    func updateBioAbilLbl() {
        switch bioAbilSeg.selectedSegmentIndex {
        case 0: bioLbl.text = pokemon.bio
        case 1: bioLbl.text = pokemon.abilities
        case 2: bioLbl.text = pokemon.moves
        default: bioLbl.text = ""
        }
    }
    
    func evoPokemon() {
        let newPokeID = Int(pokemon.id)!
        pokemon = PokemonService.inst.dataList[newPokeID]
        
        closeAnimation({
            self.initializeView()
        })
    }
    
    @IBAction func bioAbilChanged(sender: AnyObject) {
        updateBioAbilLbl()
    }

}
