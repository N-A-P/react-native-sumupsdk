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
    
    @objc func test(_ key: String   , Resolver resolve: RCTPromiseResolveBlock ,Rejecter reject: RCTPromiseRejectBlock) -> Void {
        DispatchQueue.main.async {
            var selfView = UIApplication.shared.keyWindow?.rootViewController
            while let presentVC = selfView?.presentedViewController{
                selfView = presentVC
            }
            SumUpSDK.presentLogin(from: selfView!, animated: true) {(success: Bool, error: Error?) in
                print("Did present login with success: \(success). Error: \(String(describing: error))")
                
                guard error == nil else {
                    // errors are handled within the SDK, there should be no need
                    // for your app to display any error message
                    
//                    resolve([
//                        "oke": "return with promise"
//                    ])

                    return
                }
//                reject("ERROR", "NONE", nil)
                
            }
        }
            }
    private func presentLogin() {
        // present login UI and wait for completion block to update button states
        
        
    }
    
    
}
