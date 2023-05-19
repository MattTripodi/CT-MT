//
//  LoginViewController.swift
//  CT-MT
//
//  Created by Matthew Tripodi on 8/12/22.
//

import UIKit
import CleverTapSDK

class LoginViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var identifierTextField: UITextField!
    
    //MARK: - Constants/Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Functions
    func recordUserProfile() {
        let profile: [String: AnyObject] = [
            "Name": "Matt Tripodi" as AnyObject,
            "Identity": identifierTextField.text as AnyObject,
            "Email": emailTextField.text as AnyObject,
            "ID": "1234" as AnyObject
        ]
        print(profile)
        CleverTap.sharedInstance()?.onUserLogin(profile)
    }
    
    //MARK: - IBActions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        // Identify User using onUserLogin method
        recordUserProfile()
        
        // Segue to SampleViewController
        self.performSegue(withIdentifier: "segue_sample", sender: self)
    }
    
    
    @IBAction func skipLoginButtonTapped(_ sender: UIButton) {
        // Segue to SampleViewController
        self.performSegue(withIdentifier: "segue_sample", sender: self)
    }
    
}
