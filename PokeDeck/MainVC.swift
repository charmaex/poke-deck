//
//  ViewController.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 24.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var appView: AppView!
    @IBOutlet weak var collView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collView.dataSource = self
        collView.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = .Done
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showApp:", name: "introDone", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadData", name: "reloadCollView", object: nil)

    }
    
    func reloadData() {
        collView.reloadData()
    }
    
    func showApp(notif: NSNotification) {
        appView.show()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PokemonService.inst.dataList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCellWithReuseIdentifier("PokemonCell", forIndexPath: indexPath) as! PokemonCell
        cell.initializeCell(PokemonService.inst.dataList[indexPath.row])
        return cell
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        PokemonService.inst.updateFilter(searchBar.text)
        
        if searchBar.text == nil || searchBar.text == "" {
            view.endEditing(true)
        }
    }

}

