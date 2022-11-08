//
//  CTWebviewVC.swift
//  CT-MT
//
//  Created by Matthew Tripodi on 10/31/22.
//

import UIKit
import WebKit
import CleverTapSDK

class CTWebviewVC: UIViewController {
   
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        addWebview()

        // Do any additional setup after loading the view.
    }
    
    func addWebview() {
        let ctInterface: CleverTapJSInterface = CleverTapJSInterface(config: nil)
        self.webView = WKWebView (frame: self.view.frame)
        self.webView.configuration.userContentController.add(ctInterface, name: "clevertap")
        self.webView.loadHTMLString(self.htmlStringFromFile(with: "sampleHTMLCode"), baseURL: nil)
        self.view.addSubview(self.webView)
    }
    
    private func htmlStringFromFile(with name: String) -> String {
        let path = Bundle.main.path(forResource: name, ofType: "html")
        if let result = try? String(contentsOfFile: path!, encoding: String.Encoding.utf8) {
            return result
        }
        return ""
    }

}

