
import UIKit

@objc protocol MenuAPIDelegate {
    @objc optional func didReceiveMenusSuccessfully(resultDict:AnyObject,resultStatus:Bool)
    @objc optional func didFailWithMenusError(_ error: NSError,resultStatus:Bool)
}

class MenuAPI {
    
    var delegate:MenuAPIDelegate?
    
    func getMenus() {
        
        APIHandler.sharedInstance.performGETRequest(
            (MENU_API as NSString),
            params: [:],
            success: { (response) in
                
                self.delegate?.didReceiveMenusSuccessfully!(resultDict: response, resultStatus: true)
                
        }) { (error) in
            self.delegate?.didFailWithMenusError!(error, resultStatus: false)
        }
    }
}
