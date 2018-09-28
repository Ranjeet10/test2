//
//  CategoryNewsResponseData.swift
//  agni
//
//  Created by Bidhee iMac on 8/27/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import Foundation
import ObjectMapper
class CategoryNewsResponseData: Mappable {
    
    var items: [CategoryNewsResponseInfo]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        items <- map["items"]
    }
    
    
}
