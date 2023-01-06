//
//  NativeDisplayViewController.swift
//  CT-MT
//
//  Created by Matthew Tripodi on 11/7/22.
//

import UIKit
import CleverTapSDK

class NativeDisplayViewController: UIViewController {
    
    @IBOutlet weak var clevertapTableView: UITableView!
    var featuresData : [String] = []
    var imageData : [String] = []
    var descData : [String] = []
    var nativeDisplayData : [[String:Any]] = [[:]]
    var nativeDisplayDataSecond : [[String:Any]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CleverTap.sharedInstance()?.setDisplayUnitDelegate(self)
        setData()
        setupUI()
    }
    
    func setupUI(){
        self.title = "CleverTap Features"
        let headerView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: clevertapTableView.frame.size.width, height: 10))
        headerView.backgroundColor = UIColor.clear
        clevertapTableView.tableHeaderView = headerView
        clevertapTableView.delegate = self
        clevertapTableView.dataSource = self
        clevertapTableView.reloadData()
    }
    func setData(){
        featuresData = ["Customer Data Platform","Audience Analytics","Campaign Optimisation","Omnichannel Engagement","Data Privacy and Security"];
        imageData = ["customerData","analytics","campaign","engagement","data"];
        descData = ["Understand how customers interact with your brand across platforms and build marketing strategies that enrich the customer experience.","Who are your users? Where are they? When do they drop off? Tools like Flows, Cohort Analysis, Uninstall Tracking, and Funnels help you better understand users.","Build powerful customer experiences using machine learning, triggered campaigns, intent-based segmentation and journeys.","We are the only solution that lets you orchestrate campaigns across 12 channels, including: push notifications, in-app messages and email.","Get enterprise-grade security you can trust for complete privacy, compliance, risk management, and scalability."];
    }
}

extension NativeDisplayViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featuresData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if featuresData[indexPath.row]=="nativeDisplay"{
            let discoverCell = tableView.dequeueReusableCell(withIdentifier: "discoverCell") as! DiscoverListTableViewCell
            discoverCell.isBannerCell = true
            discoverCell.setDataForBannerList(dataArray: nativeDisplayData)
            discoverCell.headerLabel.text = "- Know more about \(featuresData[indexPath.row-1]) -"
            return discoverCell
        }
        else if featuresData[indexPath.row]=="nativeDisplay_1"{
            let discoverCell = tableView.dequeueReusableCell(withIdentifier: "discoverCell") as! DiscoverListTableViewCell
            discoverCell.isBannerCell = false
            discoverCell.setDataForBannerList(dataArray: nativeDisplayDataSecond)
            discoverCell.headerLabel.text = "- Know more about \(featuresData[indexPath.row-1]) -"
            return discoverCell
        }
        else{
            let featureCell = tableView.dequeueReusableCell(withIdentifier: "featuresCell") as! FeaturesTableViewCell
            featureCell.featureImageView.image = UIImage(imageLiteralResourceName: imageData[indexPath.row])
            featureCell.nameLabel.text = featuresData[indexPath.row]
            featureCell.descLabel.text = descData[indexPath.row]
            return featureCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if featuresData[indexPath.row]=="nativeDisplay"{
            return 200;
        }
        else if featuresData[indexPath.row]=="nativeDisplay_1"{
            return 240;
        }
        else {
            return UITableView.automaticDimension
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CleverTap.sharedInstance()?.recordEvent("Feature Selected", withProps: ["feature_name":featuresData[indexPath.row]])
        if(!(featuresData[indexPath.row]=="Omnichannel Engagement") && !(featuresData[indexPath.row]=="Audience Analytics")){
            let alert = UIAlertController(title: "", message: "Tap Omnichannel Engagement or Audience Analytics to qualify for Native Display campaign", preferredStyle:.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension NativeDisplayViewController : CleverTapDisplayUnitDelegate {
    
    func displayUnitsUpdated(_ displayUnits: [CleverTapDisplayUnit]) {
        
        if displayUnits[0].type! == "custom-key-value"{
            guard
                let jsonData = displayUnits[0].json
            else { return }
            let customPairs = jsonData["custom_kv"] as! [String:Any]
            nativeDisplayDataSecond.removeAll(); nativeDisplayDataSecond.append(["images":customPairs["image_1"]!,"heading":customPairs["name_1"]!,"sub_heading":customPairs["sub_1"]!])
            nativeDisplayDataSecond.append(["images":customPairs["image_2"]!,"heading":customPairs["name_2"]!,"sub_heading":customPairs["sub_2"]!])
            nativeDisplayDataSecond.append(["images":customPairs["image_3"]!,"heading":customPairs["name_3"]!,"sub_heading":customPairs["sub_3"]!])
            nativeDisplayDataSecond.append(["images":customPairs["image_4"]!,"heading":customPairs["name_4"]!,"sub_heading":customPairs["sub_4"]!])
            
            print(nativeDisplayData)
            if(!featuresData.contains("nativeDisplay_1")){
                featuresData.insert("nativeDisplay_1", at: (featuresData.firstIndex(of: "Audience Analytics")!)+1)
                imageData.insert("", at: (featuresData.firstIndex(of: "Audience Analytics")!)+1)
                descData.insert("", at: (featuresData.firstIndex(of: "Audience Analytics")!)+1)
                UIView.transition(with: clevertapTableView, duration: 0.5, options: .transitionCrossDissolve, animations: {self.clevertapTableView.reloadData()}, completion: nil)
            }
        }
        else{
            guard
                let jsonData = displayUnits[0].contents
            else { return }
            print("JSON Data : \(String(describing: jsonData[0].mediaUrl!))")
            var image1 = jsonData[0].mediaUrl!
            image1 = String(image1.filter { !"\n".contains($0) })
            var image2 = jsonData[1].mediaUrl!
            image2 = String(image2.filter { !"\n".contains($0) })
            let dataArray = [["image":image1],["image":image2]] as [[String:Any]]
            nativeDisplayData.removeAll();
            nativeDisplayData = dataArray
            if(!featuresData.contains("nativeDisplay")){
                featuresData.insert("nativeDisplay", at: (featuresData.firstIndex(of: "Omnichannel Engagement")!)+1)
                imageData.insert("", at: (featuresData.firstIndex(of: "Omnichannel Engagement")!)+1)
                descData.insert("", at: (featuresData.firstIndex(of: "Omnichannel Engagement")!)+1)
                UIView.transition(with: clevertapTableView, duration: 0.5, options: .transitionCrossDissolve, animations: {self.clevertapTableView.reloadData()}, completion: nil)
            }
        }
    }
}
