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
    
    @objc func test(_ key: String    ) -> Void{
        
//        SumUpSDK.presentLogin(from: UIViewController, animated: true, completionBlock:)
        
//        var selfView = UIApplication.shared.keyWindow?.rootViewController
//        while let presentVC = selfView?.presentedViewController{
//                selfView = presentVC
//              }
//        SumUpSDK.presentLogin(from: presentVC, animated: true) { Bool, Error? in
//            print("LOGIN status")
//        }
        presentLogin()
        
        
       
        
        print("keys \(key)")
//        resolve([
//            "oke": "hello mother fucker"
//        ])
    }
    private func presentLogin() {
        // present login UI and wait for completion block to update button states
        DispatchQueue.main.async {
            var selfView = UIApplication.shared.keyWindow?.rootViewController
            while let presentVC = selfView?.presentedViewController{
              selfView = presentVC
            }
            SumUpSDK.presentLogin(from: selfView!, animated: true) { [weak self] (success: Bool, error: Error?) in
                print("Did present login with success: \(success). Error: \(String(describing: error))")

                guard error == nil else {
                    // errors are handled within the SDK, there should be no need
                    // for your app to display any error message
                    return
                }

             
            }
        }
        
    }
    

}
