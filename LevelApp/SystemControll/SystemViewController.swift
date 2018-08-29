//
//  SystemViewController.swift
//  LevelApp
//
//  Copyright © 2018年 cagioro. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SystemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate {
    
    var bannerView: GADBannerView!
    
    // アプリのアドレス
    var url = NSURL(string: "https://itunes.apple.com/us/app/レベルアップ/id1427127985?l=ja&ls=1&mt=8")

    @IBOutlet weak var systemTableView: UITableView!
    
    let systemArray = ["ライセンスについて", "このアプリを評価する", ""]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // In this case, we instantiate the banner with desired ad size.
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
        addBannerViewToView(bannerView)
        
        systemTableView.delegate = self
        systemTableView.dataSource  = self

    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    // 4
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-------------TableViewの処理------------------
    
    //セクションの数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myCell")
        cell.textLabel?.text = "\(systemArray[indexPath.row])"
        
        let attributedString = NSMutableAttributedString(string: systemArray[indexPath.row])
        
        attributedString.addAttribute(.link,
                                      value: "https://itunes.apple.com/us/app/レベルアップ/id1427127985?l=ja&ls=1&mt=8",
                                      range: NSString(string: systemArray[indexPath.row]).range(of: "このアプリを評価する"))
        
        
//        systemArray[indexPath.row].attributedText = attributedString
//        systemArray[indexPath.row].isSelectable = true
//        systemArray[1].attributedText = attributedString
//        systemArray[indexPath.row].delegate = self
        
        // セルの内容表示
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath)as! TodoListTableViewCell
//        let todo = self.dayTodos[indexPath.row]
//        cell.labelCell.text = todo.title
//        cell.detailCell.text = todo.descript
//        cell.labelCell!.font = UIFont(name: "HirakakuProN-W6", size: 15)
        return cell
            
        }
    
    // Cell が選択された場合
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // LicenceViewControllerへ遷移するために Segue を呼び出す
            performSegue(withIdentifier: "toLicenceViewController",sender: nil)
        }
        
        }
    
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toLicenceViewController") {
            let licVC: LicenceViewController = (segue.destination as? LicenceViewController)!
            
        }
    }
    

    

}
