//
//  BannerResponse.swift
//  agni
//
//  Created by Bidhee iMac on 8/16/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit
import ObjectMapper

class BannerResponse: Mappable {
    
    var bannerResponseData: BannerResponseData?
    var error: String?
    var message: String?
    var statusCode: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        error    <- map["error"]
        message         <- map["message"]
        statusCode      <- map["status_code"]
        bannerResponseData     <- map["data"]
        
    }
    
}
