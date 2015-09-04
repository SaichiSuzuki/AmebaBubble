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
    var evolveCount:Int = 0
    /** バブルからはみ出る具合 */
    let outBubble:CGFloat = 3
    
    /** コンストラクタ */
    init(view:UIViewController,rect:CGRect){
        self.sView = view
        self.rect = rect
    }
    
    /** アメーバ生成
    * @param fineness 細かさ(256:普通,512:多め) */
    internal func createAmeba(fineness:Int){
        // 生成
        for(var i=0;i<fineness;i++){
            // CALayer作成
            let ovalShapeLayer = CAShapeLayer()
            ovalShapeLayer.fillColor = UIColor.greenColor().CGColor
            // 粒子サイズ
            let width:CGFloat = CGFloat((arc4random() % 17) + 2)
            let height:CGFloat = CGFloat((arc4random() % 17) + 2)
            // 図形は円形(始点がずれるため調整する)
            ovalShapeLayer.path = UIBezierPath(ovalInRect:CGRect(x: rect.origin.x - width/2, y: rect.origin.y - height/2,width: width, height: height)).CGPath
            ovalShapeLayer.zPosition = 1
            ovalShapeLayer.lineWidth = 1 //輪郭の太さ
            ovalShapeLayer.strokeColor = UIColor.greenColor().CGColor //輪郭色
            sView.view.layer.addSublayer(ovalShapeLayer)
            // アメーバの元として追加
            ameba.append(ovalShapeLayer)
        }
        evolveTimer = NSTimer.scheduledTimerWithTimeInterval(1/60, target: self, selector: "evolveAmeba", userInfo: nil, repeats: false) //タイマーで呼ぶとグニュっと出る
        var degenerationTimer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "degenerationAmeba", userInfo: nil, repeats: false)
        var deleteTimer = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: "deleteAmeba", userInfo: nil, repeats: false)
    }
    
    /** アメーバを進化させる */
    func evolveAmeba(){
        for (index,p) in enumerate(ameba){
            // ベクトル
            var vX:CGFloat = 0
            var vY:CGFloat = 0
            // 進化
            vX += minusRand(rect.width)
            vY += minusRand(rect.height)
            if(arc4random() % 2 == 0){ // 更に進化
                vX += minusRand(rect.width*2)
                vY += minusRand(rect.height*2)
                if(arc4random() % 2 == 0){ // 更に進化
                    vX += minusRand(rect.width*4)
                    vY += minusRand(rect.height*4)
                }
            }
            // 範囲内に収める
            if(vX >  rect.width/outBubble) {vX =  rect.width/outBubble}
            else if(vX < -rect.width/outBubble) {vX = -rect.width/outBubble}
            if(vY >  rect.height/outBubble){vY =  rect.height/outBubble}
            else if(vY < -rect.height/outBubble){vY = -rect.height/outBubble}
            // ラインを徐々に太く
            p.lineWidth += 0.3
            // 位置更新
            p.position = CGPoint(x: p.position.x + vX, y: p.position.y + vY)
        }
    }
    
    /** アメーバを退化させる */
    func degenerationAmeba(){
        for p in ameba{
            // ベクトル
            var vX:CGFloat = -p.frame.origin.x
            var vY:CGFloat = -p.frame.origin.y
            println(p.frame.origin.x)
            // ラインを消去
            p.lineWidth = 0
            // 位置更新
            p.position = CGPoint(x: p.position.x + vX, y: p.position.y + vY)
        }
    }
    
    /** アメーバ消去 */
    internal func deleteAmeba(){
        for a in ameba{
            a.removeFromSuperlayer()
        }
        ameba.removeAll(keepCapacity: false)
    }
    
    /** CGFloat用マイナスを含んだ乱数生成 */
    func minusRand(num:CGFloat) -> CGFloat{
        return CGFloat(Double((arc4random() % UInt32(num))) - Double(num/2))
    }
}