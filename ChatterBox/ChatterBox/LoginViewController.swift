//
//  LoginViewController.swift
//  Parse
//
//  Created by Rajeev Ram on 8/20/18.
//  Copyright © 2018 Rajeev Ram. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    // UI, UX Outlet Variables
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // Backend Logic Variables

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Event Handlers

    @IBAction func onTapSignUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameTextField.text
        newUser.password = passwordTextField.text
        newUser.signUpInBackground { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Registered successfully!")
                // manually segue to logged in view
            }
        }
    }
    
    @IBAction func onTapLogIn(_ sender: Any) {
    }
    
}
