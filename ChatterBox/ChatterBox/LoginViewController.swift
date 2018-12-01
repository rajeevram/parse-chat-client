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

    /*----------UI, UX Outlet Variables----------*/
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    /*----------Event Handlers----------*/
    
    @IBAction func onSignup(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameTextField.text!
        newUser.password = passwordTextField.text!
        newUser.signUpInBackground { (success, error) in
            if let error = error {
                print(error.localizedDescription)
                self.displaySignupErrorAlert()
            } else {
                self.displaySignupSuccessAlert()
            }
        }
    }
    
    @IBAction func endEnteringCredentials(_ sender: Any) {
        view.endEditing(true);
    }
    
    @IBAction func onLogin(_ sender: Any) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if (error != nil) {
                self.displayLoginErrorAlert()
            } else {
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
        }
    }
    
    /*----------Display Alert Methods----------*/
    
    func displayLoginErrorAlert() {
        let alertController = UIAlertController(title: "Login Failed!", message: "Please enter a valid username and password combination.", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Try Again", style: .default)
        alertController.addAction(dismissAction)
        present(alertController, animated: true) {
            self.usernameTextField.text = ""
            self.passwordTextField.text = ""
        }
    }
    
    func displaySignupErrorAlert() {
        let alertController = UIAlertController(title: "Signup Failed!", message: "That username is already taken. Please choose another one.", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Try Again", style: .default)
        alertController.addAction(dismissAction)
        present(alertController, animated: true) {
            self.usernameTextField.text = ""
            self.passwordTextField.text = ""
        }
    }
    
    func displaySignupSuccessAlert() {
        let alertController = UIAlertController(title: "Signup Successful!", message: "New account created.", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Continue", style: .default) { (action) in
            self.performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
        alertController.addAction(dismissAction)
        present(alertController, animated: true) { }
    }
   
}
