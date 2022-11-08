////
////  HomeViewController.swift
////  CT-MT
////
////  Created by Matthew Tripodi on 10/31/22.
////
//
//import UIKit
//import CleverTapSDK
//
//class HomeViewController: UIViewController, CleverTapInboxViewControllerDelegate {
//
//    //MARK: - Constants/Variables
//    let props: [String: Any] = [
//        "Product Name": "CleverTap",
//        "Product ID": 1,
//        "Product Image": "https://d35fo82fjcw0y8.cloudfront.net/2018/07/26020307/customer-success-clevertap.jpg",
//        "Date": NSDate()
//    ]
//    let productImageURL = URL(string: "https://d35fo82fjcw0y8.cloudfront.net/2018/07/26020307/customer-success-clevertap.jpg")!
//    let imageView = UIImageView(frame: CGRect(x: 10, y: 50, width: 250, height: 230))
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        registerAppInbox()
//        initializeAppInbox()
//    }
//
//    //MARK: Functions
//    //    func recordUserEventWithProperties() {
//    //        print(props)
//    //        CleverTap.sharedInstance()?.recordEvent("Product viewed", withProps: props)
//    //    }
//
//    func registerAppInbox() {
//        CleverTap.sharedInstance()?.registerInboxUpdatedBlock({
//            let messageCount = CleverTap.sharedInstance()?.getInboxMessageCount()
//            let unreadCount = CleverTap.sharedInstance()?.getInboxMessageUnreadCount()
//            print("Inbox Message:\(String(describing: messageCount))/\(String(describing: unreadCount)) unread")
//        })
//    }
//
//    func initializeAppInbox() {
//        CleverTap.sharedInstance()?.initializeInbox(callback: ({ (success) in
//            let messageCount = CleverTap.sharedInstance()?.getInboxMessageCount()
//            let unreadCount = CleverTap.sharedInstance()?.getInboxMessageUnreadCount()
//            print("Inbox Message:\(String(describing: messageCount))/\(String(describing: unreadCount)) unread")
//        }))
//    }
//
//    func showAppInbox() {
//        // config the style of App Inbox Controller
//        // config the style of App Inbox Controller
//        let style = CleverTapInboxStyleConfig.init()
//        style.title = "App Inbox"
//        style.backgroundColor = UIColor.white
//        style.messageTags = ["tag1", "tag2"]
//        style.navigationBarTintColor = UIColor.red
//        style.navigationTintColor = UIColor.white
//        style.tabUnSelectedTextColor = UIColor.white
//        style.tabSelectedTextColor = UIColor.black
//        style.tabSelectedBgColor = UIColor.white
//        style.firstTabTitle = "My First Tab"
//
//        if let inboxController = CleverTap.sharedInstance()?.newInboxViewController(with: style, andDelegate: self) {
//            let navigationController = UINavigationController.init(rootViewController: inboxController)
//            self.present(navigationController, animated: true, completion: nil)
//        }
//    }
//
//    //MARK: - IBActions
//    @IBAction func inboxButtonTapped(_ sender: UIBarButtonItem) {
//        showAppInbox()
//    }
//
//}
