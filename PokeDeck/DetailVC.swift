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
    
    private var _gotData = false
    
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
    @IBOutlet weak var evoNextImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backPokeBall.delegate = self
        titleLbl.alpha = 0
        topViewConstraint.constant = view.bounds.height / 2
        bottomViewConstraint.constant = view.bounds.height / 2
        
        initializeView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        openAnimation()
    }
    
    func initializeView() {
        nameLbl.text = pokemon.name
        idLbl.text = pokemon.id
        mainImg.image = pokemon.image
        evoImg.image = pokemon.image
        evoNextImg.hidden = true
        
        pokemon.downloadData { () -> () in
            self.updatedData()
        }
    }
    
    func openAnimation() {
        let time: Double = 0.5
        let delay: Double = _gotData ? 0.1 : 0.8
        
        topViewConstraint.constant = 60
        bottomViewConstraint.constant = 28
        
        UIView.animateWithDuration(time, delay: delay, options: [.CurveEaseOut], animations: { () -> Void in
            self.view.layoutIfNeeded()
            }) { (Bool) -> Void in
                self.titleLbl.fadeIn(time)
        }
    }
    
    func closeAnimation() {
        let time: Double = 0.3
        let fadeOut: Double = 0.1
        
        let constant = view.bounds.height / 2
        topViewConstraint.constant = constant
        bottomViewConstraint.constant = constant
        
        titleLbl.fadeOut(fadeOut)
        
        UIView.animateWithDuration(time, delay: fadeOut, options: [.CurveEaseOut], animations: { () -> Void in
            self.view.layoutIfNeeded()
            }) { (Bool) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func updatedData() {
        _gotData = true
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
