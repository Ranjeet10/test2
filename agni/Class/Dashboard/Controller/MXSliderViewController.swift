//
//  MXSliderViewController.swift
//  agni
//
//  Created by Bidhee iMac on 9/23/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit
import MXParallaxHeader
import ImageSlideshow
import ObjectMapper

class MXSliderViewController: UIViewController, MXParallaxHeaderDelegate, DashboardAPIDelegate {
    
    @IBOutlet weak var slide: ImageSlideshow!
    var bannerimageArray:[AlamofireSource] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        parallaxHeader?.delegate = self
        
        let dashboardApiDelegate = DashboardAPI()
        dashboardApiDelegate.delegate = self
        dashboardApiDelegate.getImages()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
        print("hello")
    }
    
    func didReceiveImagesSuccessfully(resultDict: AnyObject, resultStatus: Bool) {
        
        if (resultDict["status"] as! String == "success") {
            if let json = resultDict as? [String: Any] {
                if let featureResponse:FeaturePhotoResponse = Mapper<FeaturePhotoResponse>().map(JSON: json) {
                    
                    let bannerInfoList = featureResponse.featureResponseData
                    for item in bannerInfoList! {
                        self.bannerimageArray.append(AlamofireSource(urlString: BASE_URI+item.photo!)!)
                    }
                    
                    slide.backgroundColor = UIColor.white
                    slide.slideshowInterval = 5.0
                    slide.pageControlPosition = PageControlPosition.insideScrollView
                    slide.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
                    slide.pageControl.pageIndicatorTintColor = UIColor.black
                    slide.contentScaleMode = UIViewContentMode.scaleAspectFill
                    slide.setImageInputs(bannerimageArray as [InputSource])
                }
            }
        }
    }
    func didFailWithImagesError(_ error: NSError, resultStatus: Bool) {
        print(error.localizedDescription)
    }
    
    @IBAction func openSliderMenu(_ sender: UIBarButtonItem) {
        self.slideMenuController()?.openLeft()
    }

    
}
