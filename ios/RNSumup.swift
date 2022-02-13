//
//  File.swift
//  react-native-sumupsdk
//
//  Created by phuong on 09/02/2022.
//

import Foundation
import SumUpSDK


@objc(RNSumupSDK)
class RNSumupSDK: NSObject {
    
    @objc static func requiresMainQueueSetup() -> Bool {
        return false
    }
    
    @objc
    func constantsToExport() -> [String: Any]! {
        return ["someKey": "someValue"]
    }
    
    
    @objc func setupWithKey(_ key: String , Resolver resolve: @escaping RCTPromiseResolveBlock , Rejecter reject: RCTPromiseRejectBlock) -> Void {
        
        DispatchQueue.main.async {
            let ok = SumUpSDK.setup(withAPIKey: key)
            print("[swift] setup ok \(ok) ")
            resolve(true)
        }
        
    }
    
    
    
    @objc func loginWithToken(_ token: String, Resolver resolve:@escaping  RCTPromiseResolveBlock , Rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        
        if(SumUpSDK.isLoggedIn){
//            print("1")
            SumUpSDK.logout { (oke: Bool,err: Error?) in
                
                SumUpSDK.login(withToken: token) { (success: Bool, error: Error?) in
                    print("2 \(success)")

                    if(success){
                        resolve(true)
                    }
                    else{
                        reject("LOGIN_FAILED", "", nil)
                    }
                }
                
            }
            
        } else {
            SumUpSDK.login(withToken: token) { (success: Bool, error: Error?) in
                // print("3 \(success) \(String(describing: error))")

                if(success){
                    resolve(true)
                }
                else{
                    reject("LOGIN_FAILED", "", nil)
                }
            }
        }
    }
    
    
    
    @objc func setupAndLogin(_ key: String ,Token token: String, Resolver resolve:@escaping  RCTPromiseResolveBlock , Rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        DispatchQueue.main.async { [self] in
            SumUpSDK.setup(withAPIKey: key)
            loginWithToken(token, Resolver: resolve, Rejecter: reject)

        }
        
    }
    
    @objc func test(_ key: String , Resolver resolve: @escaping RCTPromiseResolveBlock , Rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        DispatchQueue.main.async {
            var selfView = UIApplication.shared.keyWindow?.rootViewController
            while let presentVC = selfView?.presentedViewController{
                selfView = presentVC
            }
            SumUpSDK.login
            SumUpSDK.presentLogin(from: selfView!, animated: true) {(success: Bool, error: Error?) in
                print("Did present login with success: \(success). Error: \(String(describing: error))")
                
                guard error == nil else {
                    // errors are handled within the SDK, there should be no need
                    // for your app to display any error message
                    
                    resolve([
                        "oke": "return with promise"
                    ])
                    
                    return
                }
                reject("ERROR", "NONE", nil)
                
            }
        }
    }
    
    @objc func requestPayment(_ total: Double,Title  title: String?,Skip skipCheckoutScreen: Bool,ForeginID foreignTransactionID: String?, Resolver resolve: @escaping  RCTPromiseResolveBlock , Rejecter reject: @escaping RCTPromiseRejectBlock) -> Void {
        // print("params \(skipCheckoutScreen) \(String(describing: foreignTransactionID))")
        guard let merchantCurrencyCode = SumUpSDK.currentMerchant?.currencyCode else {
            reject("NOT_LOGGEDIN", "not logged in",  nil)
            return
        }
        let request = CheckoutRequest(total: NSDecimalNumber(value: total),
                                      title: title ?? "",
                                      currencyCode: merchantCurrencyCode)
        if(skipCheckoutScreen){
            request.skipScreenOptions = .success
        }
        
        if(foreignTransactionID != nil){
            request.foreignTransactionID = foreignTransactionID
        }
        
        DispatchQueue.main.async {
            
            var selfView = UIApplication.shared.keyWindow?.rootViewController
            while let presentVC = selfView?.presentedViewController{
                selfView = presentVC
            }
            SumUpSDK.checkout(with: request, from: selfView!) { (result: CheckoutResult?, error: Error?) in
                if let safeError = error as NSError? {
                    print("error during checkout: \(safeError)")
                    
                    if (safeError.domain == SumUpSDKErrorDomain){
                        switch safeError.code {
                        case SumUpSDKError.accountNotLoggedIn.rawValue:
                            reject("NOT_LOGGEDIN", "not logged in", nil)
                        case SumUpSDKError.checkoutInProgress.rawValue:
                            reject("CHECKOUT_INPROCESS", "Checkout in process", nil)
                        case SumUpSDKError.invalidAccessToken.rawValue:
                            reject("INVALID_TOKEN", "invalid token", nil)
                        default:
                            reject("General", "General Err", nil)
                        }
                    } else  {
                        reject("General", "General Err", nil)
                    }
                    return
                }
                
                guard let safeResult = result else {
                    //                    print("no error and no result should not happen")
                    reject("General", "General Err", nil)
                    return
                }
                if safeResult.success {
                    // okay
                    resolve(safeResult)
                }else{
                    //                    print("cancelled: no error, no success")
                    reject("CANCELED", "user cancel checkout process", nil)
                }
            }
            
            if !SumUpSDK.checkoutInProgress{
                let alert = UIAlertController(title: "Something went wrong!", message: "unable to start checkout process", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                selfView?.present(alert, animated: true, completion: {
                    // do nothing
                })
            }
            
            
        }
        
        
        
    }
    
    
}
