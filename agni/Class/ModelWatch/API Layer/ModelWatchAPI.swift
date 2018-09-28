//
//  ModelWatchAPI.swift
//  agni
//
//  Created by Bidhee iMac on 9/24/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit

@objc protocol ModelWatchAPIDelegate {
    @objc optional func didReceiveModelWatchSuccessfully(resultObj: AnyObject, resultStatus: Bool)
    @objc optional func didFailToRecieveModelWatch(resultObj: AnyObject, resultStatus: Bool)
    
}

class ModelWatchAPI {
    
    var delegate: ModelWatchAPIDelegate?
    
    func getModelImages(apiToHit: String){
        APIHandler.sharedInstance.performGETRequest(
            (apiToHit as NSString),
            params: [:],
            success: { (response) in
                self.delegate?.didReceiveModelWatchSuccessfully!(resultObj: response, resultStatus: true)
        }) { (error) in
            self.delegate?.didFailToRecieveModelWatch!(resultObj: error, resultStatus: false)
        }
    }

}
