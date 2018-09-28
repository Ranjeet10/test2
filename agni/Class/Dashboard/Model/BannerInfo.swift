//
//  BannerInfo.swift
//  agni
//
//  Created by Bidhee iMac on 8/16/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit
import ObjectMapper

class BannerInfo: Mappable {
    
    var id: Int?
    var titlt: String?
    var fileName: String?
    var link: String?
    var introText: String?
    var details: String?
    var createdAt: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id    <- map["id"]
        titlt         <- map["titlt"]
        fileName      <- map["file_name"]
        link     <- map["link"]
        introText         <- map["intro_text"]
        details      <- map["details"]
        createdAt     <- map["created_at"]
        
    }
    
}
