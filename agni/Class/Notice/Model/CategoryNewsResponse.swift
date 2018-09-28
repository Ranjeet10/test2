//
//  CategoryNewsResponse.swift
//  agni
//
//  Created by Bidhee iMac on 8/27/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import Foundation
import ObjectMapper

class CategoryNewsResponse: Mappable {
    var status: String?
    var data: CategoryNewsResponseData?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        status <- map["status"]
        data <- map["data"]
    }
    
    
}
