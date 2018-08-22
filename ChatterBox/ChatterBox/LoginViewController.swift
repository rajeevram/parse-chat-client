//
//  LoginViewController.swift
//  ChatterBox
//
//  Created by Rajeev Ram on 8/22/18.
//  Copyright © 2018 Rajeev Ram. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    // UI, UX Outlet Variables
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Event Handlers
    @IBAction func onSignup(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameTextField.text!
        newUser.password = passwordTextField.text!
        newUser.signUpInBackground { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("New user created!")
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if (error != nil) {
                print("Failed to log in!")
            } else {
                print("Logging in now!")
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
        }
    }
   
}
