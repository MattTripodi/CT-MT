//
//  AppDelegate.swift
//  CT-MT
//
//  Created by Matthew Tripodi on 8/12/22.
//

import UIKit
import UserNotifications
import CleverTapSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, CleverTapPushNotificationDelegate, CleverTapDisplayUnitDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Register for push notifications
        registerForPush()
        
        // Configure and init the default shared CleverTap instance (add CleverTap Account ID and Account token in your .plist file)
        CleverTap.autoIntegrate()
        CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue)
        print("CleverTap Debug Test: \(CleverTap.setDebugLevel(CleverTapLogLevel.debug.rawValue))")
        
        let cleverTapId = CleverTap.sharedInstance()?.profileGetID()
        print("CleverTapID = \(cleverTapId ?? "No CleverTapID")")
        
        //        CleverTap.sharedInstance()?.recordEvent("Native Display")
        //        CleverTap.sharedInstance()?.setDisplayUnitDelegate(self)
                
                // Configure and init an additional instance
        //        let ctConfig = CleverTapInstanceConfig.init(accountId: "RK4-49Z-666Z", accountToken: "1c4-432")
        //        ctConfig.logLevel = .off
        //        ctConfig.disableIDFV = true
        //        let cleverTapAdditionalInstance = CleverTap.instance(with: ctConfig)
        //        NSLog("additional CleverTap instance created for accountID: %@", cleverTapAdditionalInstance.config.accountId)
        //        cleverTapAdditionalInstance.setPushNotificationDelegate(self)
        
        return true
    }
    
    // MARK: - Setup Native Display
//    func displayUnitsUpdated(_ displayUnits: [CleverTapDisplayUnit]) {
//               // you will get display units here
//            //var units:[CleverTapDisplayUnit] = displayUnits;
//            print("Native Display is here")
//
//          // Create Notification Content
//          let notificationContent = UNMutableNotificationContent()
//
//          // Configure Notification Content
//          notificationContent.title = "Flat Rs.50 cashback with Paytm UPI"
//          //notificationContent.subtitle = "Local Notifications"
//          notificationContent.body = "Make your first Paytm UPI payment to get Rs. 50 cashback"
//            let url = Bundle.main.url(forResource: "paytm", withExtension: "png")
//            notificationContent.attachments = try! [UNNotificationAttachment.init(identifier: "image", url: url!)]
//          // Add Trigger
//          let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
//
//          // Create Notification Request
//          let notificationRequest = UNNotificationRequest(identifier: "cocoacasts_local_notification", content: notificationContent, trigger: notificationTrigger)
//
//          // Add Request to User Notification Center
//          UNUserNotificationCenter.current().add(notificationRequest) { (error) in
//              if let error = error {
//                  print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
//              }
//          }
//        }
    
    // MARK: - Setup Push Notifications
    
    func registerForPush() {
        // Register for Push notifications
        UNUserNotificationCenter.current().delegate = self
        // request Permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .badge, .alert], completionHandler: {granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        })
    }
    
    // MARK: - Notification Delegates
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        NSLog("%@: failed to register for remote notifications: %@", self.description, error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NSLog("%@: registered for remote notifications: %@", self.description, deviceToken.description)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        NSLog("%@: did receive notification response: %@", self.description, response.notification.request.content.userInfo)
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        NSLog("%@: will present notification: %@", self.description, notification.request.content.userInfo)
        CleverTap.sharedInstance()?.recordNotificationViewedEvent(withData: notification.request.content.userInfo)
        completionHandler([.badge, .sound, .list])
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        NSLog("%@: did receive remote notification completionhandler: %@", self.description, userInfo)
        completionHandler(UIBackgroundFetchResult.noData)
    }
    
    func pushNotificationTapped(withCustomExtras customExtras: [AnyHashable : Any]!) {
        NSLog("pushNotificationTapped: customExtras: ", customExtras)
    }
    
    // MARK: - Handle URL
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        NSLog("%@: open  url: %@ with options: %@", self.description, url.absoluteString, options)
        return true
    }

    // MARK: - UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

