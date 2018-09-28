//
//  LatestNewsResponseData.swift
//  agni
//
//  Created by Bidhee iMac on 8/27/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import Foundation
import ObjectMapper

class LatestNewsResponseData: Mappable {
    
    var id: Int?
    var title: String?
    var introText: String?
    var featuredImage: String?
    var publishedOn: String?
    var publishOnDate: String?
    var nepaliDate: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        title <- map["title"]
        introText <- map["introText"]
        featuredImage <- map["featuredImage"]
        publishedOn <- map["publishedOn"]
        publishOnDate <- map["publishOnDate"]
        nepaliDate <- map["nepaliDate"]
    }
    
    
}
