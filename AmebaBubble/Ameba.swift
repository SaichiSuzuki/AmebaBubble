//
//  Ameba.swift
//  AmebaBubble
//
//  Created by saichi on 2015/09/02.
//  Copyright (c) 2015年 saichi. All rights reserved.
//

import UIKit

/** アメーバを生成します */
class Ameba: UIResponder {
    
    /** アメーバ(円の集合体) */
    var ameba:[CAShapeLayer] = [CAShapeLayer]()
    /** 描画範囲 */
    let rect:CGRect!
    /** 親view */
    let sView:UIViewController!
    /** 進化用タイマー */
    var evolveTimer:NSTimer!
    /** 進化フラグ */
    var evolveFlag = 0
    
    /** コンストラクタ */
    init(view:UIViewController,rect:CGRect){
        self.sView = view
        self.rect = rect
    }
    
    /** アメーバ生成 */
    internal func createAmeba(){
        // 生成
        for(var i=0;i<620;i++){
            // CALayer作成
            let ovalShapeLayer = CAShapeLayer()
            ovalShapeLayer.fillColor = UIColor.greenColor().CGColor
            // 図形は円形
            ovalShapeLayer.path = UIBezierPath(ovalInRect: CGRect(x: rect.origin.x, y: rect.origin.y,
                width: CGFloat((arc4random() % 10) + 5), height: CGFloat((arc4random() % 10) + 5))).CGPath
            ovalShapeLayer.anchorPoint = CGPoint(x: 0,y: 0)
            sView.view.layer.addSublayer(ovalShapeLayer)
            // アメーバの元として追加
            ameba.append(ovalShapeLayer)
        }
        evolveTimer = NSTimer.scheduledTimerWithTimeInterval(1/60, target: self, selector: "evolvAmeba", userInfo: nil, repeats: true)
        var deleteTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "deleteAmeba", userInfo: nil, repeats: false)
    }
    /** アメーバを進化させる */
    func evolvAmeba(){
        for (index,p) in enumerate(ameba){
            // 角度毎のベクトル
            var vX:CGFloat = CGFloat(cos(Double(index)))
            var vY:CGFloat = CGFloat(sin(Double(index)))
            vX += CGFloat(Double((arc4random() % UInt32(rect.width)))/10.0 - Double(rect.width/20))
            vY += CGFloat(Double((arc4random() % UInt32(rect.height)))/10.0 - Double(rect.height/20))
            if(arc4random() % 2 == 0){
                vX += CGFloat(Double((arc4random() % UInt32(rect.width)))/10.0 - Double(rect.width/20))
                vY += CGFloat(Double((arc4random() % UInt32(rect.height)))/10.0 - Double(rect.height/20))
            }
            p.position = CGPoint(x: p.position.x + vX, y: p.position.y + vY)
        }
        if(evolveFlag == 0){
            evolveFlag = 1
            evolveTimer.invalidate()
            evolveTimer = NSTimer.scheduledTimerWithTimeInterval(1/30, target: self, selector: "evolvAmeba", userInfo: nil, repeats: false)
        }
    }
    
    /** アメーバ消去 */
    internal func deleteAmeba(){
        for a in ameba{
            a.removeFromSuperlayer()
        }
        ameba.removeAll(keepCapacity: false)
    }
}