//
//  ViewController.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 24.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var appView: AppView!
    @IBOutlet weak var collView: UICollectionView!
    
    var test = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test.append(Pokemon(name: "Bisasam", id: 1))
        
        collView.dataSource = self
        collView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showApp:", name: "introDone", object: nil)

    }
    
    func showApp(notif: NSNotification) {
        appView.show()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return test.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCellWithReuseIdentifier("PokemonCell", forIndexPath: indexPath) as! PokemonCell
        cell.initializeCell(test[0])
        return cell
    }

}

