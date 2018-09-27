//
//  Form.swift
//  Demo App
//
//  Created by Rohit Garg on 1/11/17.
//  Copyright © 2017 Rohit Garg. All rights reserved.
//

import Foundation

struct Form {
    
    var formValue1: String? = ""
    var formValue2: String? = ""
    var formValue3: String? = ""
    var formValue4: String? = ""
    var formValue5: String? = ""
    var formValue6: String? = ""
    var formValue7: String? = ""
    var formValue8: String? = ""

    init(value1: String, value2: String, value3: String, value4: String, value5: String, value6: String, value7: String, value8: String) {
        self.formValue1 = value1
        self.formValue2 = value2
        self.formValue3 = value3
        self.formValue4 = value4
        self.formValue5 = value5
        self.formValue6 = value6
        self.formValue7 = value7
        self.formValue8 = value8
    }
}