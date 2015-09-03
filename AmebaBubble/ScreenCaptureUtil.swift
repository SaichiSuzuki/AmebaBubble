//
//  ScreenCapture.swift
//  AmebaBubble
//
//  Created by saichi on 2015/09/03.
//  Copyright (c) 2015年 saichi. All rights reserved.
//

import UIKit

struct ScreenCaptureUtil{
    static func screenCapture(view: UIView, rect: CGRect? = nil) -> UIImage? {
        var image: UIImage?
        if let rect = rect as CGRect! {
            // ビットマップ画像のコンテキストを作成
            UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
            let context = UIGraphicsGetCurrentContext()
            CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
        }else {
            // ビットマップ画像のコンテキストを作成
            UIGraphicsBeginImageContextWithOptions(view.frame.size, false, UIScreen.mainScreen().scale)
        }
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        // 現在のコンテキストのビットマップをUIImageとして取得
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image
    }
}
