//
//  ServiceCenterResponseData.swift
//  agni
//
//  Created by Bidhee iMac on 8/21/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import Foundation
import  ObjectMapper

class NDResponseData : Mappable {
    
    var id: Int?
    var title: String?
    var content: String?
    var featuredImage: String?
    var nepaliDate: String?
    var additionalImages: [NDImage]?
    var relatedNews: [NDInfo]?
    var ndMoreRelated: [LatestNewsResponseData]?
    var url: String?
    var authorName: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id    <- map["id"]
        title         <- map["title"]
        content      <- map["content"]
        featuredImage       <- map["featuredImage"]
        nepaliDate  <- map["nepaliDate"]
        additionalImages  <- map["additionalImages"]
        relatedNews <- map["relatedNews"]
        ndMoreRelated <- map["newsRelatedToThisCategory"]
        url <- map["url"]
        authorName <- map["authorName"]
        
    }
    
}
