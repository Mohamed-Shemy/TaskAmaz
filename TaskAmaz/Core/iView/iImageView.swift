//
//  iImageView.swift
//  TaskAmaz
//
//  Created by Mohamed Shemy on Tue 11 Aug 2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import UIKit

@IBDesignable class iImageView: UIImageView
{
    // MARK: - Properties
    
    @IBInspectable var topCorner: Bool = false
        {
        didSet
        {
            if topCorner && bottomCorner
            {
                layer.maskedCorners = [.layerMinXMinYCorner,
                                       .layerMaxXMinYCorner,
                                       .layerMaxXMaxYCorner,
                                       .layerMinXMaxYCorner]
            }
            else if topCorner
            {
                layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
        }
    }
    
    @IBInspectable var bottomCorner: Bool = false
        {
        didSet
        {
            if topCorner && bottomCorner
            {
                layer.maskedCorners = [.layerMinXMinYCorner,
                                       .layerMaxXMinYCorner,
                                       .layerMaxXMaxYCorner,
                                       .layerMinXMaxYCorner]
            }
            else if bottomCorner
            {
                layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
        {
        didSet
        {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0
        {
        didSet
        {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .black
        {
        didSet
        {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
