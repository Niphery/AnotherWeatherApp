//
//  CustumView.swift
//  AnotherWeatherApp
//
//  Created by Robin Somlette on 26-03-2016.
//  Copyright © 2016 Robin Somlette. All rights reserved.
//

import UIKit

@IBDesignable class CustomView: UIView {
    
    var shadowLayer: CAShapeLayer!
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setupView()
        }
    }
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    func setupView() {
//        self.layer.cornerRadius = cornerRadius
////        self.clipsToBounds = true
//        
//        self.layer.shadowColor = UIColor.blackColor().CGColor
//        self.layer.shadowOpacity = 1
//        self.layer.shadowOffset = CGSizeZero
//        self.layer.shadowRadius = 7
////        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).CGPath
//        self.layer.shouldRasterize = true
//        
//        self.layer.borderColor = UIColor.blackColor().CGColor
//        self.layer.borderWidth = 1
        
        
        let size = self.bounds.size
        let width = size.width
        let height = size.height
        let depth = CGFloat(11.0)
        let lessDepth = 0.8 * depth
        let curvyness = CGFloat(5)
        let radius = CGFloat(1)
        
        let path = UIBezierPath()
        
        // top left
        path.moveToPoint(CGPoint(x: radius, y: height))
        
        // top right
        path.addLineToPoint(CGPoint(x: width - 2*radius, y: height))
        
        // bottom right + a little extra
        path.addLineToPoint(CGPoint(x: width - 2*radius, y: height + depth))
        
        // path to bottom left via curve
        path.addCurveToPoint(CGPoint(x: radius, y: height + depth),
                             controlPoint1: CGPoint(x: width - curvyness, y: height + lessDepth - curvyness),
                             controlPoint2: CGPoint(x: curvyness, y: height + lessDepth - curvyness))
        
//        var layer = self.view.layer
        self.layer.shadowPath = path.CGPath
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = CGSize(width: 0, height: -3)
        self.layer.shouldRasterize = true
        self.layer.cornerRadius = cornerRadius
//        self.clipsToBounds = true
    
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    
//    self.layer.shadowColor = UIColor.blackColor().CGColor
//    self.layer.shadowOpacity = 1
//    self.layer.shadowOffset = CGSizeZero
//    self.layer.shadowRadius = 10
//    self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).CGPath
//    self.layer.shouldRasterize = true
    
}
