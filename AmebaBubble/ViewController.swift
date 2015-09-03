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
        //1秒おきにアメーバ生成
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "create", userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func create(){
        var rect = CGRect(x: CGFloat(arc4random() % (UInt32)(self.view.bounds.width)), y: CGFloat(arc4random() % (UInt32)(self.view.bounds.height)), width: 200, height: 100)
        let a = Ameba(view: self,rect: rect)
        a.createAmeba()
    }
}