//
//  Extension.swift
//  buddhatravels
//
//  Created by Bidhee iMac on 8/13/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit

class Utility {
    
    static let sharedInstance = Utility()
    
    private init() {
        
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
extension UIViewController {
    
    func showLoader()  {
        print("show loader")
        //let view = UIView()
        //view.frame = self.view.frame
        //view.backgroundColor = UIColor.white
        //view.alpha = 0.7
        
        let spinnerView = UIView.init(frame: view.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
//        self.view.mask = view
//        for view in self.view.subviews {
//            view.isUserInteractionEnabled = false
//        }
    }
    
    func hideLoader() {
        print("hide loader")
//        self.view.mask = nil
//        for view in self.view.subviews {
//            view.isUserInteractionEnabled = true
//        }
    }
    
    func customizeNavigationBar() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(self.openLeftMenu) )
        //self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white 
    }
    
    
    @objc func openLeftMenu() {
        self.slideMenuController()?.openLeft()
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UIImageView {
    
    func setRounded() {
        //let radius = self.frame.width/2
        //self.layer.cornerRadius = radius
        //self.layer.masksToBounds = true
        
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}


