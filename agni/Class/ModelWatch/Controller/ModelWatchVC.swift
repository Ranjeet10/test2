//
//  ModelWatchVC.swift
//  agni
//
//  Created by Bidhee iMac on 9/24/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit
import ObjectMapper

class ModelWatchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivModel: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    
}

class ModelWatchVC: UIViewController, ModelWatchAPIDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var modelWatchCollection: UICollectionView!
    var modelList: [ModelWatchInfo] = []
    var photoFeatureList: [PhotoFeatureInfo] = []
    var apiToHit: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modelWatchCollection.delegate = self
        self.modelWatchCollection.dataSource = self
        self.customizeNavigationBar()
        
        let modelWatchApi = ModelWatchAPI()
        modelWatchApi.delegate = self
        modelWatchApi.getModelImages(apiToHit: apiToHit!)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

extension ModelWatchVC {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if apiToHit == PHOTO_FEATURE_API {
            return photoFeatureList.count
        }else{
            return modelList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "model_watch", for: indexPath) as! ModelWatchCollectionViewCell
        if apiToHit == PHOTO_FEATURE_API {
            let url = NSURL(string: BASE_URI + self.photoFeatureList[indexPath.row].photo!)
            cell.ivModel.af_setImage(withURL: url! as URL)
            cell.lblDescription.text = self.photoFeatureList[indexPath.row].title!
        }else{
            let url = NSURL(string: BASE_URI + self.modelList[indexPath.row].coverImage!)
            cell.ivModel.af_setImage(withURL: url! as URL)
            cell.lblDescription.text = self.modelList[indexPath.row].name!
        }
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 5.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if apiToHit == PHOTO_FEATURE_API {
            let vc = MODEL_WATCH_STORY_BOARD.instantiateViewController(withIdentifier: "PhotoViewVC") as! PhotoViewVC
            vc.photoFeatureInfo = photoFeatureList[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: false)
        }else {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width/2 - 2 , height:200)
    }
    
    func didReceiveModelWatchSuccessfully(resultObj: AnyObject, resultStatus: Bool) {
        if (resultObj["status"] as! String == "success") {
            if let json = resultObj as? [String: Any] {
                if apiToHit == PHOTO_FEATURE_API {
                    if let photoFeatureResponse:PhotoFeatureResponse = Mapper<PhotoFeatureResponse>().map(JSON: json) {
                        self.photoFeatureList = photoFeatureResponse.data!
                    }
                }else if apiToHit == MODEL_WATCH_API {
                    if let modelResponse:ModelWatchResponse = Mapper<ModelWatchResponse>().map(JSON: json) {
                        self.modelList = modelResponse.data!.items!
                    }
                }
                self.modelWatchCollection.reloadData()
            }
        }
    }
    
    func didFailToRecieveModelWatch(resultObj: AnyObject, resultStatus: Bool) {
        
    }
}

