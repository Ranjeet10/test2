//
//  LatestNewsAPI.swift
//  agni
//
//  Created by Bidhee iMac on 8/27/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import Foundation

@objc protocol LatestNewsAPIDelegate {
    @objc optional func didReceiveLatestNewsSuccessfully(resultDict:AnyObject,resultStatus:Bool)
    @objc optional func didFailWithLatestNewsWithError(_ error: NSError,resultStatus:Bool)
}

class LatestNewsAPI {
    
    var delegate:LatestNewsAPIDelegate?
    
    func getLatestNews(api: String, page: Int?) {
        
        var params: [String: AnyObject] = [:]
        if let page = page {
            params = ["page":page] as [String : AnyObject]
        }else {
            params = [:]
        }
        
        APIHandler.sharedInstance.performGETRequest(
            (api as NSString),
            params: params as NSDictionary,
            success: { (response) in
                
                self.delegate?.didReceiveLatestNewsSuccessfully!(resultDict: response, resultStatus: true)
                
        }) { (error) in
            self.delegate?.didFailWithLatestNewsWithError!(error, resultStatus: false)
        }
    }
}
