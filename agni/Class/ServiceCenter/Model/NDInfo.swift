//
//  ServiceCenterInfo.swift
//  agni
//
//  Created by Bidhee iMac on 8/21/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import Foundation
import ObjectMapper

class NDInfo : Mappable {
    
    var id: Int?
    var title: String?
    var featureImage: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id    <- map["id"]
        title         <- map["title"]
        featureImage      <- map["featuredImage"]
        
    }
    
}
