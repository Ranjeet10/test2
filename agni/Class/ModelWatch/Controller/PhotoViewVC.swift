//
//  PhotoVC.swift
//  agni
//
//  Created by Bidhee iMac on 9/25/18.
//  Copyright © 2018 bidhee pvt. All rights reserved.
//

import UIKit

class PhotoViewCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var ivPhoto : UIImageView!
    
}
    
    
class PhotoViewVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    var albumId: String?
    var photoFeatureInfo: PhotoFeatureInfo?
    
    @IBOutlet weak var photoViewCollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoViewCollectionView.dataSource = self
        self.photoViewCollectionView.delegate = self
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo_view", for: indexPath) as!PhotoViewCollectionViewCell
        let url = NSURL(string: BASE_URI + (photoFeatureInfo?.photo)!)
        cell.ivPhoto.af_setImage(withURL: url! as URL)
        return cell
    }
}
