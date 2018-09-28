//
//  ModelWatchResponse.swift
//  agni
//
//  Created by Bidhee iMac on 9/24/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import Foundation
import ObjectMapper

class ModelWatchResponse : Mappable {
    
    var status : String?
    var data : ModelWatch?
   
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        data   <- map["data"]
    }
    
}
