//
//  Toaster.swift
//  Toaster
//
//  Created by NSSimpleApps on 23.04.15.
//  Copyright (c) 2015 NSSimpleApps. All rights reserved.
//

import UIKit

extension UIWindow {
    
    func visibleViewController() -> UIViewController? {
        
        if let rootViewController: UIViewController  = self.rootViewController {
            
            return UIWindow.getVisibleViewControllerFrom(rootViewController)
        }
        
        return nil
    }
    
    class func getVisibleViewControllerFrom(vc: UIViewController) -> UIViewController {
        
        if vc.isKindOfClass(UINavigationController.self) {
            
            let navigationController = vc as! UINavigationController
            
            return UIWindow.getVisibleViewControllerFrom(navigationController.visibleViewController)
            
        } else if vc.isKindOfClass(UITabBarController.self) {
            
            let tabBarController = vc as! UITabBarController
            
            return UIWindow.getVisibleViewControllerFrom(tabBarController.selectedViewController!)
            
        } else {
            
            if let presentedViewController = vc.presentedViewController {
                
                return UIWindow.getVisibleViewControllerFrom(presentedViewController.presentedViewController!)
                
            } else {
                
                return vc
            }
        }
    }
}

extension NSString {
    
    func size(font: UIFont, maximumSize: CGSize, lineBreakMode: NSLineBreakMode) -> CGSize {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        
        let attributes = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle]
        
        let boundingRect = self.boundingRectWithSize(maximumSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return boundingRect.size
    }
}


class Toaster: UIView {
    
    private let initialPoint: CGPoint = CGPointMake(5, 5)
    
    private let maxDuration: NSTimeInterval = 2.0
    
    private var tapGesture = UITapGestureRecognizer()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.autoresizingMask = (UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleBottomMargin)
        self.layer.cornerRadius = 10.0
        
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 4.0
        self.layer.shadowOffset = CGSizeMake(4.0, 4.0)
        
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        
        self.tapGesture = UITapGestureRecognizer(target: self, action: Selector("hideFromSuperView:"))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func label(message: NSString) -> UILabel {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFontOfSize(14.0)
        label.textAlignment = NSTextAlignment.Center
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.clearColor()
        label.alpha = 1.0
        label.text = message as String
        
        let maximumLabelSize = CGSizeMake(self.bounds.size.width - 2*self.initialPoint.x, self.bounds.size.height - 2*self.initialPoint.y)
        
        let labelSize = message.size(label.font, maximumSize: maximumLabelSize, lineBreakMode: label.lineBreakMode)
        label.frame = CGRectMake(self.initialPoint.x, self.initialPoint.y, labelSize.width, labelSize.height)
        
        return label
    }
    
    
    func show(message: NSString) {
        
        let label = self.label(message)
        let labelSize = label.bounds.size
        
        self.bounds.size = CGSizeMake(labelSize.width + 2*self.initialPoint.x, labelSize.height + 2*self.initialPoint.y)
        self.addSubview(label)
        
        if let window: AnyObject = UIApplication.sharedApplication().windows.first {
            
            (window as! UIWindow).visibleViewController()?.view.addSubview(self)
            
            self.superview?.addGestureRecognizer(self.tapGesture)
        }
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(self.maxDuration * Double(NSEC_PER_SEC)))
        
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            
            self.hideFromSuperView(self.tapGesture)
        }
    }
    
    func show(message: NSString, duration: NSTimeInterval) {
        
        let label = self.label(message)
        let labelSize = label.bounds.size
        
        self.bounds.size = CGSizeMake(labelSize.width + 2*self.initialPoint.x, labelSize.height + 2*self.initialPoint.y)
        
        self.addSubview(label)
        
        if let window: AnyObject = UIApplication.sharedApplication().windows.first {
            
            (window as! UIWindow).visibleViewController()?.view.addSubview(self)
            
            self.superview?.addGestureRecognizer(self.tapGesture)
        }
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(duration * Double(NSEC_PER_SEC)))
        
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            
            self.hideFromSuperView(self.tapGesture)
        }
    }
    
    func hideFromSuperView(sender: UITapGestureRecognizer) {
        
        self.superview?.removeGestureRecognizer(sender)
        self.removeFromSuperview()
    }
}