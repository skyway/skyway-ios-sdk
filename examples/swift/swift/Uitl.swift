//
//  Uitl.swift
//  swift_skyway
//
//  Created by 羽田 健太郎 on 2017/11/13.
//  Copyright © 2017年 羽田 健太郎. All rights reserved.
//

import Foundation
import UIKit
import SkyWay

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
    
    class func showSelectPeerIdDialog(peerIds:[String], handler:@escaping (_ peerId:String)->Void){
        let alert = self.init(title: "接続中のPeerId", message: "接続先を選択してください", preferredStyle: .alert)
        
        for peerId in peerIds{
            let peerIdAction = UIAlertAction(title: peerId, style: .default, handler: { (alert) in
                handler(peerId)
            })
            alert.addAction(peerIdAction)
        }
        
        let viewController = UIViewController.getFrontViewController()
        viewController.present(alert, animated: true, completion: nil)

    }
}

class Util{
    
    class func loadConnectedPeerIds(peer:SKWPeer, myPeerId:String?, handler:@escaping (_ peerIds:[String]?)->Void){
        peer.listAllPeers({ (peers) -> Void in
            if let connectedPeerIds = peers as? [String]{
                let res = connectedPeerIds.filter({ (connectedPeerId) -> Bool in
                    return connectedPeerId != myPeerId
                })
                handler(res)
            }else{
                handler(nil)
            }
        })
    }
    
    class func callPeerIDSelectDialog(peer:SKWPeer, myPeerId:String?, handler:@escaping (_ selectedPeerId:String)->Void){
        self.loadConnectedPeerIds(peer: peer, myPeerId: myPeerId) { (peerIds) in
            if let _peerIds = peerIds, _peerIds.count > 0{
                UIAlertController.showSelectPeerIdDialog(peerIds: _peerIds, handler: { (peerId) in
                    handler(peerId)
                })
            }else{
                UIAlertController.oneButton("確認", message: "接続中の他のPeerIdはありません", handler: nil)
            }
        }
    }
}