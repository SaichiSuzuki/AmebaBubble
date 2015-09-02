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
        var tim = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "createAmeba", userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /** アメーバ生成 */
    func createAmeba(){
        // 初期化
        ameba.removeAll(keepCapacity: false)
        
        // ランダムな位置取得
        var bX:CGFloat = CGFloat(arc4random() % (UInt32)(self.view.bounds.width))
        var bY:CGFloat = CGFloat(arc4random() % (UInt32)(self.view.bounds.height))
        
        // 生成
        for(var i=0;i<620;i++){
            // CALayer作成
            let ovalShapeLayer = CAShapeLayer()
            ovalShapeLayer.fillColor = UIColor.greenColor().CGColor
            // 図形は円形
            ovalShapeLayer.path = UIBezierPath(ovalInRect: CGRect(x: bX, y: bY,
                width: CGFloat((arc4random() % 10) + 5), height: CGFloat((arc4random() % 10) + 5))).CGPath
            ovalShapeLayer.anchorPoint = CGPoint(x: 0,y: 0)
            view.layer.addSublayer(ovalShapeLayer)
            // アメーバの元として追加
            ameba.append(ovalShapeLayer)
        }
        evolvAmeba()
    }
    
    /** アメーバを大きくする */
    func evolvAmeba(){
        for (index,p) in enumerate(ameba){
            var vX:CGFloat = CGFloat(cos(Double(index)))
            var vY:CGFloat = CGFloat(sin(Double(index)))
            vX += CGFloat(Double((arc4random() % 500))/10.0 - 25.0)
            vY += CGFloat(Double((arc4random() % 300))/10.0 - 15.0)
            p.position = CGPoint(x: p.position.x + vX, y: p.position.y + vY)
        }
    }
}