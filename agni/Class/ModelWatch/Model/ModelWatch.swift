//
//  ModelWatch.swift
//  agni
//
//  Created by Bidhee iMac on 9/24/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import Foundation
import ObjectMapper

class ModelWatch : Mappable {
    var items : [ModelWatchInfo]?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        items   <- map["items"]
    }
}
