//
//  APIHandler.swift
//  buddhatravels
//
//  Created by Bidhee iMac on 8/12/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit
import Alamofire

class APIHandler {
    
    static let sharedInstance : APIHandler = APIHandler()
    
    private init() {
    }
    
    func performGETRequest(_ apiString:NSString,isCachingNeeded:Bool?=false,params:NSDictionary,success:@escaping (_ response: AnyObject)->Void,failure:@escaping (_ error: NSError)->Void)->() {
        
        let formattedApiUrlAsString = apiString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let paramDict = params as! [String:Any]
        let token = ""
        
        print("API:"+(apiString as String))
        print("params:",params)
        
        let requestAL = Alamofire.request(formattedApiUrlAsString!, method: .get, parameters: paramDict, headers: [
            "Authorization":token,
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json; odata=verbose"
            ])
        
        requestAL.validate()
            .responseJSON { (response) in
                self.responseHandler(response, success: success, failure: failure)
        }
    }
    
    func performPOSTRequest(_ apiString:NSString,params:[String: AnyObject],success:@escaping (_ response: AnyObject)->Void,failure:@escaping (_ error: NSError)->Void)->() {
        
        let formattedApiUrlAsString = apiString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let token = ""
        
        print("API:"+(apiString as String))
        print("params:",params)
        
        let alamofireRequest = Alamofire.request(formattedApiUrlAsString!, method: .post, parameters: params,encoding:JSONEncoding.default, headers: [
            "Authorization":token,
            "Content-Type": "application/json",
            "Accept": "application/json" //Optional
            ])
        
        alamofireRequest.validate()
            .responseJSON { (response) in
                self.responseHandler(response, success: success, failure: failure)
        }
    }
    
    
    func responseHandler(_ response:DataResponse<Any>,
                         success:(_ response: AnyObject)->Void,
                         failure:(_ error: NSError)->Void) {
        switch response.result {
        case .success:
            print("Validation Successful")
            success(response.result.value! as AnyObject)
            
        case .failure(let error):
            print("failure",error)
            
            let nserror = error as NSError
            
            if let targetStatusCode = (response.response as AnyObject).statusCode {
                print(targetStatusCode)
                failure(error as NSError)
                
            }
            else if(nserror.code == -1009) {
                let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey:"Your mobile device must be connected to the Internet with Wi-Fi or cellular network in order to use the app."])
                failure(error)
            }
            else{
                failure(error as NSError)
            }
        }
    }
    
}
