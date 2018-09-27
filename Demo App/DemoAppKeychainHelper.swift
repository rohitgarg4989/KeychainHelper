//
//  DemoAppKeychainHelper.swift
//  Demo App
//
//  Created by Rohit Garg on 1/11/17.
//  Copyright © 2017 Rohit Garg. All rights reserved.
//

// https://developer.apple.com/reference/security/1658642-keychain_services

import Foundation
import Security

// Constant Identifiers
let userAccount = "DemoAppAuthenticatedUser"
let serviceName = "DemoAppSecurityService"
let accessGroup = "com.airtel.Demo-App.DemoAppKeychainHelper"

// Arguments for the keychain queries
let kSecClassValue = kSecClass as String
let kSecAttrAccountValue = kSecAttrAccount as String
let kSecValueDataValue = kSecValueData as String
let kSecAttrServiceValue = kSecAttrService as String
let kSecMatchLimitValue = kSecMatchLimit as String
let kSecReturnDataValue = kSecReturnData as String
let kSecMatchLimitOneValue = kSecMatchLimitOne as String
let kSecClassGenericPasswordValue = kSecClassGenericPassword as String

class DemoAppKeychainHelper: NSObject {
    
    // MARK: - Class methods to perform save and load queries.
    
    /**
     Stores the string value in the keychain item under the given key.
     - parameter key: Key under which the value is stored in the keychain.
     - parameter item: value to be written to the keychain.
     */
    class func saveItemInKeychain(Item item: String, ForKey key: String) {
        self.save(item, service: key)
    }
    
    
    /**
     Retrieves the string value from the keychain that corresponds to the given key.
     - parameter key: The key that is used to read the keychain item.
     - returns: The string value from the keychain. Returns nil if unable to read the item.
     */
    class func loadItemFromKeychain(ForKey key: String) -> String? {
        return self.load(key)
    }
    
    
    // MARK: - Internal methods for saving/retriving values from keychain.
    
    internal class func save(_ item: String, service: String) {
        
        let data: Data = item.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        // Instantiate a new default keychain query
        let query: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, data],
                                                             forKeys: [kSecClassValue as NSCopying, kSecAttrServiceValue as NSCopying, kSecValueDataValue as NSCopying])
        
        // Delete the item, if already exist in keychain
        SecItemDelete(query as CFDictionary)
        
        // Add the new keychain item
        SecItemAdd(query as CFDictionary, nil)
    }
    
    internal class func load(_ service: String) -> String? {
        
        // Instantiate a new default keychain query
        let query: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, kCFBooleanTrue, kSecMatchLimitOneValue],
                                                             forKeys: [kSecClassValue as NSCopying, kSecAttrServiceValue as NSCopying, kSecReturnDataValue as NSCopying, kSecMatchLimitValue as NSCopying])
        
        var dataTypeRef :AnyObject?
        
        // Search for the keychain items
        let status: OSStatus = SecItemCopyMatching(query, &dataTypeRef)
        var contentsOfKeychain: String? = nil
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                contentsOfKeychain = String(data: retrievedData, encoding: String.Encoding.utf8)
            }
        } else {
            print("Nothing was retrieved from the keychain for key -> \(service). Status code \(status)")
        }
        
        return contentsOfKeychain
    }
    
}
