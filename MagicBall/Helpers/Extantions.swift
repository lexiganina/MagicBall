//
//  Extantions.swift
//  MagicBall
//
//  Created by Alex Hanina on 1/22/22.
//

import Foundation
import UIKit

extension String {
    func encodeURIComponent() -> String? {
        let characterSet = NSMutableCharacterSet.urlQueryAllowed
        
        return self.addingPercentEncoding(withAllowedCharacters: characterSet)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension UIImageView {
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 17, height: 20)
        self.layer.shadowRadius = 1
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 500).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}

