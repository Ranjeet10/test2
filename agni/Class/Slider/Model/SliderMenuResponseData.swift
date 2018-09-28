//
//  SliderMenuResponseData.swift
//  agni
//
//  Created by Bidhee iMac on 8/27/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import Foundation
import ObjectMapper

class SliderMenuResponseData: Mappable {
    
    var id: Int?
    var name: String?
    var alias: String?
    
    init(id: Int, name: String, alias: String) {
        self.id = id
        self.name = name
        self.alias = alias
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        alias <- map["alias"]
    }
    
    
    
    
    
}
