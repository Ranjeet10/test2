//
//  BannerResponse.swift
//  agni
//
//  Created by Bidhee iMac on 8/16/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit
import ObjectMapper

class BannerResponseData: Mappable {
    
    var total: Int?
    var perPage: Int?
    var currentPage: Int?
    var lastPage: Int?
    var from: Int?
    var to: Int?
    var bannerInfoList: [BannerInfo]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        total    <- map["total"]
        perPage         <- map["per_page"]
        currentPage      <- map["current_page"]
        lastPage       <- map["last_page"]
        from  <- map["from"]
        to  <- map["to"]
        bannerInfoList     <- map["data"]
        
    }
}
