//
//  Extensions.swift
//  ToDoListApp
//
//  Created by Abin Berly on 05/01/25.
//

import UIKit
import Foundation

//Extensions
extension UIView {
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    @IBInspectable var borderColor: UIColor {
        get {
            guard let color = self.layer.borderColor else {
                return UIColor.clear
            }
            return UIColor(cgColor: color)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    @IBInspectable var clipsToCircle: Bool {
        get {
            return false
        }
        set {
            self.layer.cornerRadius = self.frame.height/2
        }
    }
}
