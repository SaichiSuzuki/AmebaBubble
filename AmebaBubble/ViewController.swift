//
//  ViewController.swift
//  AmebaBubble
//
//  Created by saichi on 2015/09/02.
//  Copyright (c) 2015年 saichi. All rights reserved.
//

import UIKit

/** アメーバを生成します */
class ViewController: UIViewController {

    var ameba:[CAShapeLayer] = [CAShapeLayer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1秒おきにアメーバ生成
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "createAmeba", userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /** アメーバ生成 */
    func createAmeba(){
        // アメーバRect作成
        var rect = CGRect(x: CGFloat(arc4random() % (UInt32)(self.view.bounds.width)), y: CGFloat(arc4random() % (UInt32)(self.view.bounds.height/2)), width: CGFloat(arc4random() % 100), height: CGFloat(arc4random() & 100))
        let a = Ameba(view: self,rect: rect)
        // アメーバ細かさ設定
        var fineness:Int = (Int(rect.width) * Int(rect.height)) / 6
        if(fineness>700){fineness = 700}
        // 作成
        a.createAmeba(fineness)
    }
}