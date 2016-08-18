//
//  RoundedImage.swift
//  AnotherWeatherApp
//
//  Created by Robin Somlette on 29-03-2016.
//  Copyright © 2016 Robin Somlette. All rights reserved.
//

import UIKit


@IBDesignable
class  RoundedImageView: UIImageView {
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
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 1
        
        
    }
    
    override func awakeFromNib() {
        setupView()
    }

}