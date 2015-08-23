//
//  Toaster.swift
//  Toaster
//
//  Created by NSSimpleApps on 23.04.15.
//  Copyright (c) 2015 NSSimpleApps. All rights reserved.
//

import UIKit

//UIEdgeInsetsInsetRect

extension UIViewController {

    func topMostViewController() -> UIViewController {
    
        if let presentedViewController = self.presentedViewController {
        
            return presentedViewController.topMostViewController()
        
        } else if let navigationController = self as? UINavigationController {
            
            let visibleViewController = navigationController.visibleViewController
        
            return visibleViewController.topMostViewController()
        
        } else if let tabBarController = self as? UITabBarController {
        
            let selectedViewController = tabBarController.selectedViewController
        
            return selectedViewController!.topMostViewController()
            
        } else {
            
            return self
        }
    }
}

private extension NSString {
    
    func size(font: UIFont, maximumSize: CGSize, lineBreakMode: NSLineBreakMode) -> CGSize {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        
        let attributes = [NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle]
        
        let boundingRect = self.boundingRectWithSize(maximumSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return boundingRect.size
    }
}

private extension UIApplication {
    
    var mainView: UIView? {
        
        if let appDelegate = self.delegate as? AppDelegate {
            
            if let rootViewController = appDelegate.window?.rootViewController {
                
                return rootViewController.topMostViewController().view
            }
        }
        return nil
    }
}

public enum ToasterPosition {
    
    case LeftXTopY
    case CenterXTopY
    case RightXTopY
    
    case LeftXCenterY
    case CenterXCenterY
    case RightXCenterY
    
    case LeftXBottomY
    case CenterXBottomY
    case RightXBottomY
    
    func center(rect: CGRect) -> CGPoint {
        
        let width = rect.size.width
        let height = rect.size.height
        
        switch self {
            
        case LeftXTopY:
            return CGPointMake(width/6, height/6)
        case CenterXTopY:
            return CGPointMake(width/2, height/6)
        case RightXTopY:
            return CGPointMake(5*width/6, height/6)
            
        case LeftXCenterY:
            return CGPointMake(width/6, height/2)
        case CenterXCenterY:
            return CGPointMake(width/2, height/2)
        case RightXCenterY:
            return CGPointMake(5*width/6, height/2)
            
        case LeftXBottomY:
            return CGPointMake(width/6, 5*height/6)
        case CenterXBottomY:
            return CGPointMake(width/2, 5*height/6)
        case RightXBottomY:
            return CGPointMake(5*width/6, 5*height/6)
        }
    }
}

private let offset: CGFloat = 3

class Toaster : UIView {
    
    private var tapGestureRecognizer = UITapGestureRecognizer()
    
    private var addLabelBlock: ((String) -> ())?
    
    convenience init(topLeftCorner: CGPoint) {
        
        let mainViewFrame = UIApplication.sharedApplication().mainView!.frame
        
        self.init(frame: CGRect(origin: topLeftCorner, size: CGSizeMake(mainViewFrame.size.width/3, mainViewFrame.size.height/3)))
        
        self.addLabelBlock = { (message: String) -> Void in
            
            let label = self.label(message, frame: self.frame)
            label.frame.origin = CGPoint(x: offset, y: offset)
            
            self.frame = CGRect(origin: self.frame.origin, size: label.frame.rectByInsetting(dx: -offset, dy: -offset).size)
            
            self.addSubview(label)
        }
    }
    
    convenience init(center: CGPoint) {
        
        let mainViewFrame = UIApplication.sharedApplication().mainView!.frame
        
        self.init(frame: CGRect(origin: mainViewFrame.origin, size: CGSizeMake(mainViewFrame.size.width/3, mainViewFrame.size.height/3)))
        
        self.addLabelBlock = { (message: String) -> Void in
            
            let label = self.label(message, frame: self.frame)
            label.frame.origin = CGPoint(x: offset, y: offset)
            
            self.frame = CGRect(origin: CGPointZero, size: label.frame.rectByInsetting(dx: -offset, dy: -offset).size)
            self.center = center
            
            self.addSubview(label)
        }
    }

    convenience init(toasterPosition: ToasterPosition = .CenterXCenterY) {
        
        let mainViewFrame = UIApplication.sharedApplication().mainView!.frame
        
        self.init(center: toasterPosition.center(mainViewFrame))
    }
    
    
    override private init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.autoresizingMask = (.FlexibleLeftMargin | .FlexibleRightMargin | .FlexibleTopMargin | .FlexibleBottomMargin)
        
        self.layer.cornerRadius = 10.0
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 4.0
        self.layer.shadowOffset = CGSizeMake(4.0, 4.0)
        
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("cleanUp:"))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func label(message: String, frame: CGRect) -> UILabel {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFontOfSize(14.0)
        label.textAlignment = NSTextAlignment.Center
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.clearColor()
        label.text = message
        
        let maximumLabelSize = frame.rectByInsetting(dx: offset, dy: offset).size
        
        let labelSize = message.size(label.font, maximumSize: maximumLabelSize, lineBreakMode: label.lineBreakMode)
        
        label.frame = CGRect(origin: CGPointZero, size: labelSize)
        
        return label
    }
    
    private func hideToaster() {
        
        let defaultDuration: NSTimeInterval = 0.7
        
        UIView.animateWithDuration(defaultDuration, animations: { () -> Void in
            
            self.alpha = 0
            
        }) { (finished) -> Void in
            
            self.cleanUp(self.tapGestureRecognizer)
        }
    }
    
    internal func cleanUp(sender: UITapGestureRecognizer) {
        
        sender.view?.removeGestureRecognizer(sender)
        self.removeFromSuperview()
    }
    
    func show(message: String, duration: NSTimeInterval = 2.0) {
        
        self.addLabelBlock!(message)
        
        if let mainView = UIApplication.sharedApplication().mainView {
            
            mainView.addSubview(self)
            mainView.addGestureRecognizer(self.tapGestureRecognizer)
        }
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(duration * Double(NSEC_PER_SEC)))
        
        dispatch_after(delayTime, dispatch_get_main_queue()) {
        
            self.hideToaster()
        }
    }
}

extension UIView {
    
    func showToaster(message: String, center: CGPoint, duration: NSTimeInterval = 2.0) {
        
        let toaster = Toaster(center: center)
        toaster.show(message, duration: duration)
    }
    
    func showToaster(message: String, topLeftCorner: CGPoint, duration: NSTimeInterval = 2.0) {
        
        let toaster = Toaster(topLeftCorner: topLeftCorner)
        toaster.show(message, duration: duration)
    }
    
    func showToaster(message: String, toasterPosition: ToasterPosition, duration: NSTimeInterval = 2.0) {
        
        let toaster = Toaster(toasterPosition: toasterPosition)
        toaster.show(message, duration: duration)
    }
}
