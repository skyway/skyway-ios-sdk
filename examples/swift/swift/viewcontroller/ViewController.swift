//
//  ViewController.swift
//  swift
//
//  Created by 羽田 健太郎 on 2017/11/13.
//  Copyright © 2017年 羽田 健太郎. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var apikeyLabel:UILabel!
    @IBOutlet weak var domainLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let apikey = (UIApplication.shared.delegate as? AppDelegate)?.skywayAPIKey{
            self.apikeyLabel.text = apikey
            self.apikeyLabel.textColor = UIColor.darkGray
        }
        if let domain = (UIApplication.shared.delegate as? AppDelegate)?.skywayDomain{
            self.domainLabel.text = domain
            self.domainLabel.textColor = UIColor.darkGray
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "show_media" || identifier == "show_data"{
            if (UIApplication.shared.delegate as? AppDelegate)?.skywayAPIKey == nil || (UIApplication.shared.delegate as? AppDelegate)?.skywayDomain == nil{
                UIAlertController.oneButton("エラー", message: "APIKEYかDOMAINが設定されていません", handler: nil)
            }
        }        
        return true
    }
    
}

