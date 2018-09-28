//
//  DashboardAPI.swift
//  agni
//
//  Created by Bidhee iMac on 8/16/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit

@objc protocol DashboardAPIDelegate {
    @objc optional func didReceiveImagesSuccessfully(resultDict:AnyObject,resultStatus:Bool)
    @objc optional func didFailWithImagesError(_ error: NSError,resultStatus:Bool)
    @objc optional func didReceiveMenusSuccessfully(resultDict:AnyObject,resultStatus:Bool)
    @objc optional func didFailWithMenusError(_ error: NSError,resultStatus:Bool)
}

class DashboardAPI {
    
    var delegate:DashboardAPIDelegate?
    
    
    func getImages() {
        
        APIHandler.sharedInstance.performGETRequest(
            (FEATURE_PHOTO_API as NSString),
            params: [:],
            success: { (response) in
                
                self.delegate?.didReceiveImagesSuccessfully!(resultDict: response, resultStatus: true)
                
        }) { (error) in
            self.delegate?.didFailWithImagesError!(error, resultStatus: false)
        }
    }
    
    func getCategories() {
        APIHandler.sharedInstance.performGETRequest(
            (MENU_API as NSString),
            params: [:],
            success: { (response) in
                
                self.delegate?.didReceiveMenusSuccessfully!(resultDict: response, resultStatus: true)
                
        }) { (error) in
            self.delegate?.didFailWithMenusError!(error, resultStatus: false)
        }
    }
    
    
}
