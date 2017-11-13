//
//  Uitl.swift
//  swift_skyway
//
//  Created by 羽田 健太郎 on 2017/11/13.
//  Copyright © 2017年 羽田 健太郎. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func getFrontViewController() -> UIViewController {
        var tc = UIApplication.shared.keyWindow?.rootViewController;
        while ((tc!.presentedViewController) != nil) {
            tc = tc!.presentedViewController;
        }
        return tc!;
    }
}


extension UIAlertController {
    
    class func oneButton(_ title: String, message: String, btnOk: String = "OK", handler: ((UIAlertAction?) -> Void)?) {
        let alert = self.init(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: btnOk, style: .default, handler: handler)
        
        alert.addAction(okAction)
        
        let viewController = UIViewController.getFrontViewController()
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
