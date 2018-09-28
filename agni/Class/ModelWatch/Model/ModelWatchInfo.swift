//
//  ModelWatchInfo.swift
//  agni
//
//  Created by Bidhee iMac on 9/24/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import Foundation
import ObjectMapper

class ModelWatchInfo: Mappable {

    var id: Int?
    var name: String?
    var coverImage: String?

    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        id         <- map["id"]
        name       <- map["name"]
        coverImage <- map["coverImage"]
    }

}
