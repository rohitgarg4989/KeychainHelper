//
//  Utilities.swift
//  Demo App
//
//  Created by Rohit Garg on 1/11/17.
//  Copyright © 2017 Rohit Garg. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    
    func showAlertWithMessageAndTitle(_ message: String, title: String) {
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension UIImageView {
    
    // MARK: - Image downloader method
    
    public func downloadImageFrom(_ link:String, completionHandler: @escaping (_ image: UIImage?) -> Void ) {
        
        let url:URL! = URL(string: link)
        let urlRequest = URLRequest(url: url)
        
        let session: URLSession = {
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
            return session
        }()
        
        
        let task: URLSessionDataTask = session.dataTask( with: urlRequest as URLRequest, completionHandler: { (data, response, error) in
            
            guard error == nil else {
                print("Error while downloading \(error!.localizedDescription)")
                return
            }
            
            guard let image =  UIImage(data: data!) else {
                return
            }
            
            DispatchQueue.main.async {
                self.image =  image
                self.adjustContentMode()
                completionHandler(image)
            }
            
        })
        
        task.resume()
        
    }
    
    internal func adjustContentMode() {
        
        guard let image = self.image else {
            return
        }
        
        if image.size.width > bounds.size.width || image.size.height > bounds.size.height {
            contentMode = .scaleToFill
        } else {
            contentMode = .scaleAspectFill
        }
        
        self.clipsToBounds = true
    }
    
}
