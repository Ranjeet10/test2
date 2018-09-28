//
//  FeaturePhotoResponse.swift
//  agni
//
//  Created by Bidhee iMac on 9/23/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit
import ObjectMapper

class FeaturePhotoResponse: Mappable {
    
    var featureResponseData: [FeatureResponseInfo]?
    var status: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        status      <- map["status"]
        featureResponseData     <- map["data"]
        
    }
    
}
