//
//  BGImageView.swift
//  PokeDeck
//
//  Created by Jan Dammshäuser on 25.02.16.
//  Copyright © 2016 Jan Dammshäuser. All rights reserved.
//

import UIKit

class BGImageView: UIImageView {

    override func awakeFromNib() {
        clipsToBounds = true
    }

}
