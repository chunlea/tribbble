//
//  DribbbleShotCell.swift
//  tribbble
//
//  Created by Chunlea Ju on 7/27/15.
//  Copyright © 2015 Chunlea Ju. All rights reserved.
//

import UIKit

class DribbbleShotCell: UICollectionViewCell {
    @IBOutlet weak var shotImage: UIImageView!

    @IBOutlet weak var viewsCount: UILabel!
    @IBOutlet weak var commentsCount: UILabel!
    @IBOutlet weak var likesCount: UILabel!
    
    override func drawRect(rect: CGRect)
    {
        layer.masksToBounds = true
        layer.cornerRadius = 2.0

        // The shadowlayer seems not working well with cornerRadius
        let shadowLayer = CALayer()
        shadowLayer.shadowColor = UIColor.blackColor().CGColor
        shadowLayer.shadowOpacity = 0.07
        shadowLayer.shadowRadius = 2.0
        shadowLayer.shadowOffset = CGSizeMake(0.0, 2.0)
        layer.addSublayer(shadowLayer)
    }
}
