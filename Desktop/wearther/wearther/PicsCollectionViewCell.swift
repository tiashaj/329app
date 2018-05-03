//
//  PicsCollectionViewCell.swift
//  wearther
//
//  Created by Amy Fang on 5/2/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit

class PicsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}
