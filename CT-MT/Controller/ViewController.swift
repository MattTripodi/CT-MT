//
//  ViewController.swift
//  CT-MT
//
//  Created by Matthew Tripodi on 8/12/22.
//

import UIKit
import CleverTapSDK

class ViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    
    //MARK: - Constants/Variables
    let props: [String: Any] = [
        "Product Name": "CleverTap",
        "Product ID": 1,
        "Product Image": "https://d35fo82fjcw0y8.cloudfront.net/2018/07/26020307/customer-success-clevertap.jpg",
        "Date": NSDate()
    ]
    let productImageURL = URL(string: "https://d35fo82fjcw0y8.cloudfront.net/2018/07/26020307/customer-success-clevertap.jpg")!
    let imageView = UIImageView(frame: CGRect(x: 10, y: 50, width: 250, height: 230))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Functions
    func recordUserProfile() {
        let profile: [String: AnyObject] = [
            "Email": emailTextField.text as AnyObject
        ]
        print(profile)
        CleverTap.sharedInstance()?.profilePush(profile)
    }
    
    func recordUserEventWithProperties() {
        print(props)
        CleverTap.sharedInstance()?.recordEvent("Product viewed", withProps: props)
    }
    
    //MARK: - IBActions
    @IBAction func viewProductButtonTapped(_ sender: UIButton) {
        recordUserProfile()
        recordUserEventWithProperties()
        
        // Alert to let user know product has been viewed
        let alert = UIAlertController(
            title: "Product",
            message: """
            \(props["Product Name"] ?? "No product")
            \(props["Product ID"] ?? "to show")
            """,
            preferredStyle: .alert
        )
        
        //Download image from URL
        DispatchQueue.global().async {
            //Fetch Image Data
            if let data = try? Data(contentsOf: self.productImageURL) {
                DispatchQueue.main.async {
                    //Create Image and Update Image View
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
    
        //Addd downloaded image to alert
        alert.view.addSubview(imageView)
        //Size image correctly in alert
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = true
        alert.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: alert.view, attribute: .centerX, multiplier: 1, constant: 0))
        alert.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: alert.view, attribute: .centerY, multiplier: 1, constant: 0))
        alert.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 64.0))
        alert.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 64.0))
                
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}
