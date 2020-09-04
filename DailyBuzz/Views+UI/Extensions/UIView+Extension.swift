//
//  UIView+Extension.swift
//  DailyBuzz
//
//  Created by Simon Italia on 9/4/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//


import UIKit


//MARK: - Support Storyboard UIView attribute updates
extension UIView {
    
    //Support Live view changes in SB
    @IBInspectable
    var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var viewBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var viewBorderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    
    //set view attributes
    func setProperties(borderWidth: CGFloat?, borderColor: UIColor?, cornerRadius: CGFloat?) {
        if let borderWidth = borderWidth {
            self.layer.borderWidth = borderWidth
        }
            
        if let borderColor = borderColor {
            self.layer.borderColor = borderColor.cgColor
        }
        
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    
    //set view shape to circle
    func makeCircle() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}
