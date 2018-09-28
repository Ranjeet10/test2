

import Foundation
import ObjectMapper

class SlideMenuResponse: Mappable {
    
    var status: String?
    var data: [SliderMenuResponseData]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        status <- map["status"]
        data <- map["data"]
    }
    
    
}
