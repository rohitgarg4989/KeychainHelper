//
//  LoginViewController.swift
//  Demo App
//
//  Created by Rohit Garg on 1/11/17.
//  Copyright © 2017 Rohit Garg. All rights reserved.
//

import UIKit

let KEY_USERNAME = "KeyForUserName"
let KEY_PASSWORD = "KeyForPassword"

class LoginViewController: UIViewController {

    // MARK: Interface Builder outlets
    
    @IBOutlet var userNameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    
    // MARK: - UIViewController View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - IBAction

    @IBAction func login(_ sender: AnyObject) {
        
        // Check that text has been entered into both the username and password fields.
        guard let username = userNameField.text, let password = passwordField.text, !username.isEmpty && !password.isEmpty
            else {
                self.showAlertWithMessageAndTitle("Please fill all the fields", title: "Demo App")
                return
        }
        
        DemoAppKeychainHelper.saveItemInKeychain(Item: username, ForKey: KEY_USERNAME) // saving username to keychain
        DemoAppKeychainHelper.saveItemInKeychain(Item: password, ForKey: KEY_PASSWORD) // saving password to keychain
        
        if let savedUsername = DemoAppKeychainHelper.loadItemFromKeychain(ForKey: KEY_USERNAME){
            print(savedUsername)
        }
        
        if let savedPassword = DemoAppKeychainHelper.loadItemFromKeychain(ForKey: KEY_PASSWORD){
            print(savedPassword)
        }

        self.performSegue(withIdentifier: "showFormVC", sender: self)
    }

}
