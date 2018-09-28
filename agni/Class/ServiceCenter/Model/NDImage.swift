//
//  NDImage.swift
//  agni
//
//  Created by Bidhee iMac on 9/25/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import Foundation
import ObjectMapper

class NDImage: Mappable {
    
    var id: Int?
    var image: String?

    
    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        
        id <- map["id"]
        image <- map["image"]
    }
    
    
}
