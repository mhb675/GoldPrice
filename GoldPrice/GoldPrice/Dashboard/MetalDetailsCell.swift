//
//  MetalDetailsCell.swift
//  GoldPrice
//
//  Created by Hassan Bhatti on 17/11/2017.
//  Copyright © 2017 Hassan Bhatti. All rights reserved.
//

import UIKit

class MetalDetailsCell: UICollectionViewCell {
    
    @IBOutlet weak var metalImageView: UIImageView!
    
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var changePercentLabel: UILabel!
    @IBOutlet weak var highValueLabel: UILabel!
    @IBOutlet weak var lowValueLabel: UILabel!
    @IBOutlet weak var openValueLabel: UILabel!
    @IBOutlet weak var closeValueLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func updateCell(metalImage:UIImage, metal:Metal)
    {
        self.metalImageView.image = metalImage
        self.currentValueLabel.text = String(describing: metal.open!)
        self.changePercentLabel.text = String(format: "%.2f (%.2f%%)", metal.change!, (metal.percentChange)!)
        self.highValueLabel.text = String(describing: metal.high!)
        self.lowValueLabel.text = String(describing: metal.low!)
        self.openValueLabel.text = String(describing: metal.open!)
        self.closeValueLabel.text = String(describing: metal.close!)
        self.unitLabel.text = metal.unit!
        self.dateLabel.text = metal.date!        
    }

}
