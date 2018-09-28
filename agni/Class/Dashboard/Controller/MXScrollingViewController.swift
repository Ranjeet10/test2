//
//  MXScrollingViewController.swift
//  agni
//
//  Created by Bidhee iMac on 9/23/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit
import MXParallaxHeader

class MXScrollingViewController: MXScrollViewController, MXScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.scrollView.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

}
