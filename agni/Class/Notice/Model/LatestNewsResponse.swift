//
//  LatestNewsResponse.swift
//  agni
//
//  Created by Bidhee iMac on 8/27/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import Foundation
import ObjectMapper

class LatestNewsResponse : Mappable {
    var status: String?
    var data: [LatestNewsResponseData]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        status <- map["status"]
        data <- map["data"]
    }
    
    
}
