//
//  CustomDateView.swift
//  AnotherWeatherApp
//
//  Created by Robin Somlette on 28-03-2016.
//  Copyright © 2016 Robin Somlette. All rights reserved.
//

import UIKit

@IBDesignable

class CustomDateView: UIView {
    

    
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
//        self.layer.cornerRadius = 5.0
//        self.clipsToBounds = true
//        
//        self.layer.shadowColor = UIColor.blackColor().CGColor
//        self.layer.shadowOpacity = 0.7
////        self.layer.shadowOffset = CGSize(width: 10, height: 10)
//        self.layer.shadowOffset = CGSizeZero
//        self.layer.shadowRadius = 10
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 5.0).CGPath
//        self.layer.shouldRasterize = true
        
//        self.layer.borderColor = UIColor.blackColor().CGColor
//        self.layer.borderWidth = 1
        
//        let borderBottom = CALayer()
//        borderBottom.backgroundColor = UIColor.lightGrayColor().CGColor
//        borderBottom.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 0.5)
//        
//        self.layer.addSublayer(borderBottom)
//        
//        let borderTop = CALayer()
//        borderTop.backgroundColor = UIColor.lightGrayColor().CGColor
//        borderTop.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: -0.5)
//        
//        self.layer.addSublayer(borderTop)
        
    }
    
    override func awakeFromNib() {
        setupView()
    }
}
