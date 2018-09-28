//
//  SliderVc.swift
//  agni
//
//  Created by Nabin on 8/17/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit
import ObjectMapper

class SliderTableViewCell: UITableViewCell {
    @IBOutlet weak var ivSliderImage:UIImageView?
    @IBOutlet weak var lblSliderName:UILabel?
}

class SliderVc: UIViewController , MenuAPIDelegate{
    
    var sliderImageArray = ["Home","Vehicle","Spare Parts","Spare Parts","Service Center","Notice"]
    var SliderLabelArray = ["Home","Breaking News","Important News","Model Watch","Videos","Feature"]
    var secondSection = ["Settings", "About Us"]
    var sliderMenuResponse: [SliderMenuResponseData] = []
    var indexPathToSend: Int = 0
    
    @IBOutlet weak var sliderTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderTableView.dataSource = self
        sliderTableView.delegate = self
    }

}
extension SliderVc:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if(section == 0) {
            return "Menu"
        }else{
            return "Preference"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0) {
            return self.SliderLabelArray.count
        }else{
            return self.secondSection.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var sectionArray: [String] = []
        if(indexPath.section == 0) {
            sectionArray = SliderLabelArray
        }else {
            sectionArray = secondSection
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SliderTableViewCell
        //let image = self.SliderLabelArray[indexPath.row]
        //cell.ivSliderImage?.image = UIImage(named: image!)
        let label  = sectionArray[indexPath.row]
        cell.lblSliderName?.text = label
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        let childrenVC = rootVC?.childViewControllers
        let nc = childrenVC?.first as? UINavigationController
        
        if(indexPath.section == 0) {
            switch indexPath.row {
                case 0:
                    let vc = HOME_STORY_BOARD.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
                    (self.slideMenuController()?.mainViewController as! UINavigationController).pushViewController(vc, animated: false)
                case 1:
                    let vc = NOTICE_STORY_BOARD.instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
                    vc.isNotForHome = true
                    vc.VCTitle = self.SliderLabelArray[indexPath.row]
                    vc.homeApiToHit = indexPath.row
                    (self.slideMenuController()?.mainViewController as! UINavigationController).pushViewController(vc, animated: false)
                case 2:
                    let vc = NOTICE_STORY_BOARD.instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
                    vc.isNotForHome = true
                    vc.VCTitle = self.SliderLabelArray[indexPath.row]
                    vc.homeApiToHit = indexPath.row
                    (self.slideMenuController()?.mainViewController as! UINavigationController).pushViewController(vc, animated: false)
                case 3:
                    let vc = MODEL_WATCH_STORY_BOARD.instantiateViewController(withIdentifier: "ModelWatchVC") as! ModelWatchVC
                    vc.apiToHit = MODEL_WATCH_API
                    (self.slideMenuController()?.mainViewController as! UINavigationController).pushViewController(vc, animated: false)
                case 4:
                    print(indexPath.row)
                case 5:
                    let vc = MODEL_WATCH_STORY_BOARD.instantiateViewController(withIdentifier: "ModelWatchVC") as! ModelWatchVC
                    vc.apiToHit = PHOTO_FEATURE_API
                    (self.slideMenuController()?.mainViewController as! UINavigationController).pushViewController(vc, animated: false)
                default:
                    let vc = HOME_STORY_BOARD.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
                    (self.slideMenuController()?.mainViewController as! UINavigationController).pushViewController(vc, animated: false)
                
            }
        }else {
            
            switch indexPath.row {
                case 0:
                    print(indexPath.row)
                case 1:
                    print(indexPath.row)
                default:
                    let vc = HOME_STORY_BOARD.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
                    (self.slideMenuController()?.mainViewController as! UINavigationController).pushViewController(vc, animated: false)
                
                }
            
        }
        
        
        
        self.slideMenuController()?.closeLeft()
        
    }
}
