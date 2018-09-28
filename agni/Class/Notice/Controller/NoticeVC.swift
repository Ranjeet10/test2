
import UIKit
import ObjectMapper

class NoticeTableViewCell : UITableViewCell {
    
    @IBOutlet weak var ivNotice : UIImageView!
    @IBOutlet weak var lblNoticeHeading: UILabel!
    @IBOutlet weak var lblNoticeDate: UILabel!
}


class NoticeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, LatestNewsAPIDelegate {
   
    var VCTitle: String?
    var newsId: Int?
    var isNotForHome: Bool?
    var homeApiToHit: Int = 0
    var apiToHit = ""
    var page:Int?
    var isFirstPageHit = true
    
    @IBOutlet weak var noticeTableView: UITableView!
    
    var latestNewsResponse: [LatestNewsResponseData] = []
    var categoryNewsResponse: [CategoryNewsResponseInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let yourBackImage = UIImage(named: "arrow_back")
//        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
//
//        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        self.title = VCTitle
        
        self.setUpAPI()
        
        self.noticeTableView.dataSource = self
        self.noticeTableView.delegate = self
        self.noticeTableView.tableFooterView = UIView()
        
                
        let latestNewsAPI = LatestNewsAPI()
        latestNewsAPI.delegate = self
        latestNewsAPI.getLatestNews(api: apiToHit, page: page)
        Loader.sharedInstance.showLoader()
        
    }
    
    func setUpAPI(){
        isFirstPageHit = true
        if isNotForHome == true {
            page = nil
            switch homeApiToHit {
                
                case 1:
                    apiToHit = IMPORTANT_NEWS_API
                case 2:
                    apiToHit = TRENDING_NEWS_API
                default:
                    apiToHit = IMPORTANT_NEWS_API
                
            }
        }else {
            page = 1
            
            switch newsId {
                
                case -1:
                    apiToHit = BREAKING_NEWS_API
                case -2:
                    apiToHit = LATEST_NEWS_API
                default:
                    apiToHit = CATEGORY_NEWS_API + "/\(newsId!)/list"
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isNotForHome == true) {
            return latestNewsResponse.count
        }else{
            if(newsId == -1 || newsId == -2) {
                return latestNewsResponse.count
            }else {
                return categoryNewsResponse.count
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notice_cell") as! NoticeTableViewCell
        
        if(isNotForHome == true) {
            
            cell.lblNoticeHeading.text = latestNewsResponse[indexPath.row].title
            cell.lblNoticeDate.text = latestNewsResponse[indexPath.row].nepaliDate
            let image = BASE_URI + latestNewsResponse[indexPath.row].featuredImage!
            let url = NSURL(string: image)
            cell.ivNotice.af_setImage(withURL: url! as URL)
            
        }else {
            
            if(newsId == -1 || newsId == -2) {
                cell.lblNoticeHeading.text = latestNewsResponse[indexPath.row].title
                cell.lblNoticeDate.text = latestNewsResponse[indexPath.row].nepaliDate
                let image = BASE_URI + latestNewsResponse[indexPath.row].featuredImage!
                let url = NSURL(string: image)
                cell.ivNotice.af_setImage(withURL: url! as URL)
            }else {
                
                cell.lblNoticeHeading.text = categoryNewsResponse[indexPath.row].title
                cell.lblNoticeDate.text = categoryNewsResponse[indexPath.row].nepaliDate
                let image = BASE_URI + categoryNewsResponse[indexPath.row].featuredImage!
                let url = NSURL(string: image)
                cell.ivNotice.af_setImage(withURL: url! as URL)
            }
            
            
            
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(isFirstPageHit == false && isNotForHome == false) {
            let lastSectionIndex = tableView.numberOfSections - 1
            let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
                let activityIndicator = UIActivityIndicatorView()
                activityIndicator.hidesWhenStopped = true
                activityIndicator.activityIndicatorViewStyle = .whiteLarge
                activityIndicator.color = Utility.sharedInstance.hexStringToUIColor(hex: "df3237")
                activityIndicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                self.noticeTableView.tableFooterView = activityIndicator
                self.noticeTableView.tableFooterView?.isHidden = false
                
                let latestNewsAPI = LatestNewsAPI()
                latestNewsAPI.delegate = self
                latestNewsAPI.getLatestNews(api: apiToHit, page: page)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105.0
    }
    
    
    func didReceiveLatestNewsSuccessfully(resultDict: AnyObject, resultStatus: Bool) {
        
        if(isNotForHome == true) {
            if (resultDict["status"] as! String == "success") {
                if let json = resultDict as? [String: Any] {
                    if let latestNewsResponse:LatestNewsResponse = Mapper<LatestNewsResponse>().map(JSON: json) {
                        self.latestNewsResponse =  latestNewsResponse.data!
                        self.noticeTableView.reloadData()
                    }
                }
            }
            
        }else{
            
            if(newsId == -1 || newsId == -2) {
                
                if (resultDict["status"] as! String == "success") {
                    if let json = resultDict as? [String: Any] {
                        if let latestNewsResponse:LatestNewsResponse = Mapper<LatestNewsResponse>().map(JSON: json) {
                            self.latestNewsResponse =  latestNewsResponse.data!
                            self.noticeTableView.reloadData()
                        }
                    }
                }
                
            }else {
                
                if (resultDict["status"] as! String == "success") {
                    if let json = resultDict as? [String: Any] {
                        if let categoryNewsResponse:CategoryNewsResponse = Mapper<CategoryNewsResponse>().map(JSON: json) {
                            
                            if (isFirstPageHit == true) {
                                self.categoryNewsResponse =  categoryNewsResponse.data!.items!
                            }else {
                                let newPageResponse = categoryNewsResponse.data!.items!
                                self.categoryNewsResponse.append(contentsOf: newPageResponse)
                            }
                            
                            self.noticeTableView.reloadData()
                        }
                    }
                    page = page! + 1
                    self.isFirstPageHit = false
                }
                
            }
            
        }
        
        Loader.sharedInstance.removeLoader()
        self.noticeTableView.tableFooterView?.isHidden = true
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsNewsVC = SERVICE_CENTER_STORY_BOARD.instantiateViewController(withIdentifier: "ServiceCenterVC") as! ServiceCenterVC
        
        if(isNotForHome == true) {
            detailsNewsVC.VCTitle = self.latestNewsResponse[indexPath.row].title
            detailsNewsVC.newsId = self.latestNewsResponse[indexPath.row].id
        }else{
            
            if(newsId == -1 || newsId == -2){
                detailsNewsVC.VCTitle = self.latestNewsResponse[indexPath.row].title
                detailsNewsVC.newsId = self.latestNewsResponse[indexPath.row].id
            }else{
                detailsNewsVC.VCTitle = self.categoryNewsResponse[indexPath.row].title
                detailsNewsVC.newsId = self.categoryNewsResponse[indexPath.row].id
            }
            
        }
       
        self.navigationController?.pushViewController(detailsNewsVC, animated: true)
    }
    
    func didFailWithLatestNewsWithError(_ error: NSError, resultStatus: Bool) {
        print(error.localizedDescription)
        Loader.sharedInstance.removeLoader()
        self.noticeTableView.tableFooterView?.isHidden = true
    }
    
    @objc func closeViewController() {
        let vc = UINavigationController(rootViewController: HOME_STORY_BOARD.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC)
        self.slideMenuController()?.changeMainViewController(vc, close: false)
    }

}
