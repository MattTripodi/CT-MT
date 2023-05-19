//
//  NativeDisplay2ViewController.swift
//  CT-MT
//
//  Created by Matthew Tripodi on 5/9/23.
//

import UIKit
import CleverTapSDK

class NativeDisplay2ViewController: UIViewController, CleverTapDisplayUnitDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CleverTap.sharedInstance()?.setDisplayUnitDelegate(self)
    }
    
    
    @IBAction func event1Trigger(_ sender: UIButton) {
        print("Event 1 Trigger")
        
        let props: Dictionary<String, Any> = [
            "Product name": "Casio Chronograph Watch",
            "Category": "Mens Accessories",
            "Price": 59.99,
            "Date": NSDate()
        ]
        
        CleverTap.sharedInstance()?.recordEvent("Event1Trigger", withProps: props)
    }
    
    @IBAction func event2Trigger(_ sender: UIButton) {
        print("Event 2 Trigger")
        
        let props: Dictionary<String, Any> = [
            "Product name": "Rolex Watch",
            "Category": "Mens Accessories",
            "Price": 10000.00,
            "Date": NSDate()
        ]
        
        CleverTap.sharedInstance()?.recordEvent("Event2Trigger", withProps: props)
    }
    
    func displayUnitsUpdated(_ displayUnits: [CleverTapDisplayUnit]) {
        let units:[CleverTapDisplayUnit] = displayUnits;
        var unitCount  = 1
        for unit in displayUnits {
            let contents = unit.contents
            var json = unit.json
            
            var contentIterator = contents?.makeIterator()
            while let content = contentIterator?.next() {
                let title = content.title
                let mediaURL = content.mediaUrl
                
                print(title)
                print(mediaURL)
            }
           
//            print(contents)
//            print(json)
            
        }
    }
    

}
