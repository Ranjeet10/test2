//
//  Loader.swift
//  agni
//
//  Created by Bidhee iMac on 8/21/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit

class Loader: NSObject {
    
    static let sharedInstance : Loader = Loader()
    
    private override init() {
    }
    
    private let activityIndicator = UIActivityIndicatorView()
    
    private func setupLoader() {
        removeLoader()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.color = Utility.sharedInstance.hexStringToUIColor(hex: "df3237")
    }
    
    func showLoader() {
        setupLoader()
        
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let holdingView = appDel.window!.rootViewController!.view!
        
        DispatchQueue.main.async {
            self.activityIndicator.center = holdingView.center
            self.activityIndicator.startAnimating()
            holdingView.addSubview(self.activityIndicator)
            UIApplication.shared.beginIgnoringInteractionEvents()
        }
    }
    
    func removeLoader(){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    func addLoaderForPagination() -> UIView {
        setupLoader()
        return activityIndicator
    }

}
