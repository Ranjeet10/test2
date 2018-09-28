//
//  FeatureResponseInfo.swift
//  agni
//
//  Created by Bidhee iMac on 9/23/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit
import ObjectMapper

class FeatureResponseInfo: Mappable {
    
    var id: Int?
    var title: String?
    var photo: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id    <- map["id"]
        title         <- map["title"]
        photo      <- map["photo"]
        
        
    }
    
}
