//
//  PhotoFeatureResponse.swift
//  agni
//
//  Created by Bidhee iMac on 9/25/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import Foundation
import ObjectMapper

class PhotoFeatureResponse: Mappable {
    var status: String?
    var data: [PhotoFeatureInfo]?
    
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        status <- map["status"]
        data   <- map["data"]
    }
    
}
