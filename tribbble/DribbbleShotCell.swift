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
    
    @IBOutlet weak var viewsIcon: UIImageView!
    @IBOutlet weak var likesIcon: UIImageView!
    @IBOutlet weak var commentsIcon: UIImageView!
    
    
    @IBOutlet weak var commentsIconWidth: NSLayoutConstraint!
    @IBOutlet weak var likesIconWidth: NSLayoutConstraint!
    @IBOutlet weak var viewsIconWidth: NSLayoutConstraint!
    override func drawRect(rect: CGRect)
    {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOpacity = 0.07
        layer.shadowRadius = 2.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
    }
}
