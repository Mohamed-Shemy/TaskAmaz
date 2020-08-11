//
//  iView.swift
//  iControl
//
//  Created by Mohamed Shemy on Thu,13 Feb,2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import UIKit

@IBDesignable class iView: UIView
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
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.darkGray
        {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowOffsetWidth: CGFloat = 0.0
        {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowOffsetHeight: CGFloat = 0.0
        {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0
        {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0
        {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0
        {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderColor: UIColor = .black
        {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    // MARK: - Override
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
}
