//
//  FormViewController.swift
//  Demo App
//
//  Created by Rohit Garg on 1/11/17.
//  Copyright © 2017 Rohit Garg. All rights reserved.
//

import UIKit

let KEY_IMAGE_CACHE = "demoappimagecache"

var userform : Form? = nil

class FormViewController: UIViewController {
    
    // MARK: Interface Builder outlets
    
    @IBOutlet var formField1: UITextField!
    @IBOutlet var formField2: UITextField!
    @IBOutlet var formField3: UITextField!
    @IBOutlet var formField4: UITextField!
    @IBOutlet var formField5: UITextField!
    @IBOutlet var formField6: UITextField!
    @IBOutlet var formField7: UITextField!
    @IBOutlet var formField8: UITextField!

    @IBOutlet var imageView: UIImageView!

    
    // MARK: - UIViewController View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.downloadImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    
    // MARK: - IBAction
    
    @IBAction func done(_ sender: AnyObject) {
        
        userform = Form(value1:formField1.text!, value2: formField2.text!, value3: formField3.text!, value4: formField4.text!, value5: formField5.text!, value6: formField6.text!, value7: formField7.text!, value8: formField8.text!)
        
        self.performSegue(withIdentifier: "showNextVC", sender: self)

    }
    
    
    // MARK: - Custom method
    
    func downloadImage() {
        
        // check if image is already saved in cache
        if(MyImageCache.sharedCache.object(forKey: KEY_IMAGE_CACHE as AnyObject) != nil) {
            // use cache image
            self.imageView.image = MyImageCache.sharedCache.object(forKey: KEY_IMAGE_CACHE as AnyObject) as? UIImage
        }
        else {
            // download the image from link
            self.imageView.downloadImageFrom("https://media.glassdoor.com/l/4e/0d/f8/14/apple-store.jpg") { (image) in
                MyImageCache.sharedCache.setObject(image!, forKey: KEY_IMAGE_CACHE as AnyObject)
            }
        }
        
    }
}

class MyImageCache {
    
    static let sharedCache: NSCache = { () -> NSCache<AnyObject, AnyObject> in 
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = 20 // Max 20 images in memory.
        cache.totalCostLimit = 10*1024*1024 // Max 10MB used.
        return cache
    }()
    
}
