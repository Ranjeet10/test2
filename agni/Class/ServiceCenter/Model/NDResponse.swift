//
//  ServiceCenterResponse.swift
//  agni
//
//  Created by Bidhee iMac on 8/21/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import Foundation
import ObjectMapper

class NDResponse : Mappable {
    
    var status: String?
    var data: NDResponseData?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        status    <- map["status"]
        data         <- map["data"]
        
    }
}
