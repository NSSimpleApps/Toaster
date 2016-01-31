//
//  Toaster.swift
//  Toaster
//
//  Created by NSSimpleApps on 23.04.15.
//  Copyright (c) 2015 NSSimpleApps. All rights reserved.
//

import UIKit

private let offset: CGFloat = 3

private class Toaster : UIView {
    
    private override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.removeFromSuperview()
    }
    
    var duration: NSTimeInterval = 2
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        
        super.willMoveToSuperview(newSuperview)
        
        if let _ = newSuperview {
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(self.duration * Double(NSEC_PER_SEC)))
            
            dispatch_after(delayTime, dispatch_get_main_queue()) { [weak self] () in
                
                self?.hideToaster()
            }
        }
    }
    
    convenience init(topLeftCorner: CGPoint, message: String) {
        
        let screenBounds = UIScreen.mainScreen().bounds.size
        
        let estimatedSize = CGSize(width: screenBounds.width/3, height: screenBounds.height/3)
        
        let label = Toaster.label(message, size: estimatedSize)
        label.frame.origin = CGPoint(x: offset, y: offset)
        
        self.init(frame: CGRect(origin: topLeftCorner, size: label.frame.insetBy(dx: -offset, dy: -offset).size))
        
        self.addSubview(label)
    }
    
    convenience init(center: CGPoint, message: String) {
        
        let screenBounds = UIScreen.mainScreen().bounds.size
        
        let estimatedSize = CGSize(width: screenBounds.width/3, height: screenBounds.height/3)
        
        let label = Toaster.label(message, size: estimatedSize)
        label.frame.origin = CGPoint(x: offset, y: offset)
        
        let origin = CGPoint(x: center.x - label.frame.width/2, y: center.y - label.frame.height/2)
        
        self.init(frame: CGRect(origin: origin, size: label.frame.insetBy(dx: -offset, dy: -offset).size))
        
        self.addSubview(label)
    }
    
    convenience init(topLeftCorner: CGPoint, attributedMessage: NSAttributedString) {
        
        let screenBounds = UIScreen.mainScreen().bounds.size
        
        let estimatedSize = CGSize(width: screenBounds.width/3, height: screenBounds.height/3)
        
        let label = Toaster.label(attributedMessage, size: estimatedSize)
        label.frame.origin = CGPoint(x: offset, y: offset)
        
        self.init(frame: CGRect(origin: topLeftCorner, size: label.frame.insetBy(dx: -offset, dy: -offset).size))
        
        self.addSubview(label)
    }
    
    convenience init(center: CGPoint, attributedMessage: NSAttributedString) {
        
        let screenBounds = UIScreen.mainScreen().bounds.size
        
        let estimatedSize = CGSize(width: screenBounds.width/3, height: screenBounds.height/3)
        
        let label = Toaster.label(attributedMessage, size: estimatedSize)
        label.frame.origin = CGPoint(x: offset, y: offset)
        
        let origin = CGPoint(x: center.x - label.frame.width/2, y: center.y - label.frame.height/2)
        
        self.init(frame: CGRect(origin: origin, size: label.frame.insetBy(dx: -offset, dy: -offset).size))
        
        self.addSubview(label)
    }
    
    override private init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.autoresizingMask = ([.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleBottomMargin])
        
        self.layer.cornerRadius = 10.0
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 4.0
        self.layer.shadowOffset = CGSizeMake(4.0, 4.0)
        
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private class func label(message: String, size: CGSize) -> UILabel {
        
        let label = UILabel(frame: CGRect(origin: CGPointZero, size: size))
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFontOfSize(14.0)
        label.textAlignment = NSTextAlignment.Center
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.clearColor()
        label.text = message
        label.sizeToFit()
        
        return label
    }
    
    private class func label(message: NSAttributedString, size: CGSize) -> UILabel {
        
        let label = UILabel(frame: CGRect(origin: CGPointZero, size: size))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.Center
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.backgroundColor = UIColor.clearColor()
        label.attributedText = message
        label.sizeToFit()
        
        return label
    }
    
    private func hideToaster() {
        
        let defaultDuration: NSTimeInterval = 0.7
        
        UIView.animateWithDuration(defaultDuration, animations: { [weak self] () -> Void in
            
            self?.alpha = 0
            
        }) { [weak self] (finished) -> Void in
            
            if let strongSelf = self {
                
                strongSelf.removeFromSuperview()
            }
        }
    }
}

public extension UIView {
    
    public func showToasterWithMessage(message: String, center: CGPoint, duration: NSTimeInterval = 2.0) {
        
        let toaster = Toaster(center: center, message: message)
        toaster.duration = duration
        
        self.addSubview(toaster)
    }
    
    public func showToasterWithMessage(message: String, topLeftCorner: CGPoint, duration: NSTimeInterval = 2.0) {
        
        let toaster = Toaster(topLeftCorner: topLeftCorner, message: message)
        toaster.duration = duration
        
        self.addSubview(toaster)
    }
    
    public func showToasterWithAttributedMessage(attributedMessage: NSAttributedString, topLeftCorner: CGPoint, duration: NSTimeInterval = 2.0) {
        
        let toaster = Toaster(topLeftCorner: topLeftCorner, attributedMessage: attributedMessage)
        toaster.duration = duration
        
        self.addSubview(toaster)
    }
    
    public func showToasterWithAttributedMessage(attributedMessage: NSAttributedString, center: CGPoint, duration: NSTimeInterval = 2.0) {
        
        let toaster = Toaster(center: center, attributedMessage: attributedMessage)
        toaster.duration = duration
        
        self.addSubview(toaster)
    }
}
