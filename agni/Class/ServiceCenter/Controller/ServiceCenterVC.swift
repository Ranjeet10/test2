//
//  ServiceCenterVC.swift
//  agni
//
//  Created by Bidhee iMac on 8/21/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit
import ObjectMapper

class ServiceCenterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivShowRoomImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
}

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ivImage: UIImageView!
}

class ServiceCenterVC: UIViewController, UITableViewDataSource, UITableViewDelegate, NDAPIDelegate {
    
    @IBOutlet weak var serviceCenterTableView: UITableView!
    @IBOutlet weak var imageTableView: UITableView!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var ntitle: UILabel!
    
    var ndRelated: [NDInfo] = []
    var ndRelatedMore: [LatestNewsResponseData] = []
    var ndImage: [NDImage] = []
    
    var VCTitle: String?
    var newsId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.serviceCenterTableView.delegate = self
        self.serviceCenterTableView.dataSource = self
        self.serviceCenterTableView.tableFooterView = UIView()
        
        self.imageTableView.delegate = self
        self.imageTableView.dataSource = self
        self.imageTableView.tableFooterView = UIView()
        
        self.title = VCTitle
        print(newsId)
        
        let ndAPI = NDAPI()
        ndAPI.delegate = self
        ndAPI.getND(id: "test")
        Loader.sharedInstance.showLoader()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(tableView == serviceCenterTableView){
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(tableView == serviceCenterTableView) {
            if(section == 0) {
                return "First"
            }else {
                return "second"
            }
        }else{
            return "Photo"
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == serviceCenterTableView) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "detail_news_cell") as! ServiceCenterTableViewCell
            
            if(indexPath.section == 0) {
                
                let value = ndRelated[indexPath.row]
                
                
                let imageURL = NSURL(string: BASE_URI + value.featureImage!)
                
                cell.ivShowRoomImage.af_setImage(withURL: imageURL! as URL)
                
                cell.lblName.text = value.title!
                
                cell.lblTime.text = ""
                
                return cell
                
            }else if(indexPath.section == 1){
                
                let value = ndRelatedMore[indexPath.row]
                
                let imageURL = NSURL(string: BASE_URI + value.featuredImage!)
                
                cell.ivShowRoomImage.af_setImage(withURL: imageURL! as URL)
                
                cell.lblName.text = value.title!
                
                cell.lblTime.text = value.nepaliDate!
                
                
            }
            
            cell.separatorInset = .zero
            cell.layoutMargins = .zero
            
            return cell
            
        }else {
            
            let value = ndImage[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "nd_image") as! ImageTableViewCell
            
            let imageURL = NSURL(string: BASE_URI + value.image!)
            
            cell.ivImage.af_setImage(withURL: imageURL! as URL)
            
           // cell.separatorInset = .zero
           // cell.layoutMargins = .zero
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(tableView == serviceCenterTableView) {
            
            
            if(indexPath.section == 0) {
                return 105.0
            }else {
                return 105.0
            }
            
        }else{
            return 120.0
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == serviceCenterTableView){
            
            if(section == 0){
                return self.ndRelated.count
            }else{
                return self.ndRelatedMore.count
            }
            
        }else {
            
            return self.ndImage.count
            
        }
    }
    
    func didReceiveNDSuccessfully(resultDict: AnyObject, resultStatus: Bool) {
        print(resultDict)
        if (resultDict["status"] as! String == "success") {
            if let json = resultDict as? [String: Any] {
                if let ndResponse:NDResponse = Mapper<NDResponse>().map(JSON: json) {
                    self.ndImage = ndResponse.data!.additionalImages!
                    self.ndRelated = ndResponse.data!.relatedNews!
                    self.ndRelatedMore = ndResponse.data!.ndMoreRelated!
                    
                    self.serviceCenterTableView.reloadData()
                    self.imageTableView.reloadData()
                    
                    let imageURL = NSURL(string: BASE_URI + (ndResponse.data?.featuredImage)!)
                    self.bannerImage.af_setImage(withURL: imageURL! as URL)
                    self.desc.text = ndResponse.data?.content
                    self.time.text = "\(ndResponse.data!.nepaliDate!) | \(ndResponse.data!.authorName!)"
                    self.ntitle.text = ndResponse.data!.title!
                    
                }
            }
        }
        Loader.sharedInstance.removeLoader()
    }
    
    func didFailWithNDError(_ error: NSError, resultStatus: Bool) {
        print(error.localizedDescription)
        Loader.sharedInstance.removeLoader()
    }
    
}
