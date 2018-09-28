//
//  ServiceCenterAPI.swift
//  agni
//
//  Created by Bidhee iMac on 8/21/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit

@objc protocol NDAPIDelegate {
    @objc optional func didReceiveNDSuccessfully(resultDict:AnyObject,resultStatus:Bool)
    @objc optional func didFailWithNDError(_ error: NSError,resultStatus:Bool)
}

class NDAPI {
    
    var delegate:NDAPIDelegate?
    
    func getND(id: String) {
        
        APIHandler.sharedInstance.performGETRequest(
            (DETAILS_API as NSString),
            params: [:],
            success: { (response) in
                
                self.delegate?.didReceiveNDSuccessfully!(resultDict: response, resultStatus: true)
                
        }) { (error) in
            self.delegate?.didFailWithNDError!(error, resultStatus: false)
        }
        
    }
    
}

