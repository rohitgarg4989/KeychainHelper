//
//  NextViewController.swift
//  Demo App
//
//  Created by Rohit Garg on 1/11/17.
//  Copyright © 2017 Rohit Garg. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.printUserForm()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func printUserForm() {
        print(userform?.formValue1 ?? "")
        print(userform?.formValue2 ?? "")
        print(userform?.formValue3 ?? "")
        print(userform?.formValue4 ?? "")
        print(userform?.formValue5 ?? "")
        print(userform?.formValue6 ?? "")
        print(userform?.formValue7 ?? "")
        print(userform?.formValue8 ?? "")
    }
}
