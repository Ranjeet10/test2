//
//  HomeVC.swift
//  buddhatravels
//
//  Created by Bidhee iMac on 8/9/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireImage
import ImageSlideshow
import PagingMenuController
import MXParallaxHeader

private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    
    var controller: [SliderMenuResponseData]
    var viewControllerArray =  NSMutableArray()
    init(controller: [SliderMenuResponseData]) {
        self.controller = controller
        
        for eachController in controller {
            
            let vc = NOTICE_STORY_BOARD.instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
            vc.isNotForHome = false
            vc.newsId = eachController.id!
            viewControllerArray.add(vc)
        }
    }
    
    
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(array: controller), pagingControllers: pagingControllers)
    }
    
    fileprivate var pagingControllers: [UIViewController] {
        return viewControllerArray as! [NoticeVC]
    }
    
    fileprivate struct MenuOptions: MenuViewCustomizable {
        
        var menuArray : [SliderMenuResponseData]
        var array = NSMutableArray()
        
        init(array : [SliderMenuResponseData]) {
            self.menuArray = array
        }
        
        var displayMode: MenuDisplayMode {
            return .standard(widthMode: .flexible, centerItem: true, scrollingMode: .scrollEnabled)
        }
        
        var itemsOptions: [MenuItemViewCustomizable] {
            
            for menu in menuArray {
                array.add(MenuItem(name: menu.name!))
            }
            return array as! [MenuItemViewCustomizable]
            
            
        }
    }
    
    fileprivate struct MenuItem: MenuItemViewCustomizable {
        
        var name: String
        init(name: String) {
            self.name = name
        }
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: self.name))
        }
        
    }
}



class DashboardVC: UIViewController, DashboardAPIDelegate {
    
    
    var bannerimageArray:[AlamofireSource] = []
    var sliderMenuResponse: [SliderMenuResponseData] = []
    //var menu: [String] = ["ब्रेकिङ न्युज","ताजा समाचार","मुख्य समाचार","प्रचलित"]
    var firstMenu: SliderMenuResponseData = SliderMenuResponseData.init(id: -1, name: "ब्रेकिङ न्युज", alias: "Breaking News")
    var secondMenu: SliderMenuResponseData = SliderMenuResponseData.init(id: -2, name: "ताजा समाचार", alias: "Latest News")
    
    var menus : [SliderMenuResponseData] = []
    
    //var menu: [String] = ["ब्रेकिङ न्युज","ताजा समाचार"]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let dashboardAPI = DashboardAPI()
        dashboardAPI.delegate = self
        dashboardAPI.getCategories()
        //self.customizeNavigationBar()
        //self.navigationController?.navigationBar.barTintColor = Utility.sharedInstance.hexStringToUIColor(hex: "DF3237")
        
            
    }
    
    @IBAction func openSliderMenu(_ sender: UIBarButtonItem) {
        self.slideMenuController()?.openLeft()
    }
    
    func setupViewPagers() {
        
        let options = PagingMenuOptions(controller: self.menus)
        let pagingMenuController = PagingMenuController(options: options)
        
        //pagingMenuController.view.frame.origin.y += 64
        //pagingMenuController.view.frame.size.height -= 64
        pagingMenuController.onMove = { state in
            switch state {
            case let .willMoveController(menuController, previousMenuController):
                print(previousMenuController)
                print(menuController)
            case let .didMoveController(menuController, previousMenuController):
                print(previousMenuController)
                print(menuController)
            case let .willMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            case let .didMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            case .didScrollStart:
                print("Scroll start")
            case .didScrollEnd:
                print("Scroll end")
            }
        }
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func didReceiveMenusSuccessfully(resultDict: AnyObject, resultStatus: Bool) {
        
        if (resultDict["status"] as! String == "success") {
            if let json = resultDict as? [String: Any] {
                if let menuResponse:SlideMenuResponse = Mapper<SlideMenuResponse>().map(JSON: json) {
                    self.sliderMenuResponse =  menuResponse.data!
                    self.sliderMenuResponse = self.sliderMenuResponse.sorted(by: { $0.id! < $1.id!})
                    menus.append(firstMenu)
                    menus.append(secondMenu)
                    for menu in sliderMenuResponse {
                        self.menus.append(menu)
                    }
                    self.setupViewPagers()
                }
            }
        }
        
        Loader.sharedInstance.showLoader()
        
    }
    
    func didFailWithMenusError(_ error: NSError, resultStatus: Bool) {
        print(error.localizedDescription)
        Loader.sharedInstance.removeLoader()
    }
    
}

