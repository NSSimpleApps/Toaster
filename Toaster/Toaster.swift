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
    
    fileprivate override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.removeFromSuperview()
    }
    
    var duration: TimeInterval = 2
    
    override func willMove(toSuperview newSuperview: UIView?) {
        
        super.willMove(toSuperview: newSuperview)
        
        if let _ = newSuperview {
            
            let delayTime = DispatchTime.now() + Double(Int64(self.duration * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            
            DispatchQueue.main.asyncAfter(deadline: delayTime) { [weak self] () in
                
                self?.hideToaster()
            }
        }
    }
    
    convenience init(topLeftCorner: CGPoint, message: String) {
        
        let screenBounds = UIScreen.main.bounds.size
        
        let estimatedSize = CGSize(width: screenBounds.width/3, height: screenBounds.height/3)
        
        let label = Toaster.label(message, size: estimatedSize)
        label.frame.origin = CGPoint(x: offset, y: offset)
        
        self.init(frame: CGRect(origin: topLeftCorner, size: label.frame.insetBy(dx: -offset, dy: -offset).size))
        
        self.addSubview(label)
    }
    
    convenience init(center: CGPoint, message: String) {
        
        let screenBounds = UIScreen.main.bounds.size
        
        let estimatedSize = CGSize(width: screenBounds.width/3, height: screenBounds.height/3)
        
        let label = Toaster.label(message, size: estimatedSize)
        label.frame.origin = CGPoint(x: offset, y: offset)
        
        let origin = CGPoint(x: center.x - label.frame.width/2, y: center.y - label.frame.height/2)
        
        self.init(frame: CGRect(origin: origin, size: label.frame.insetBy(dx: -offset, dy: -offset).size))
        
        self.addSubview(label)
    }
    
    convenience init(topLeftCorner: CGPoint, attributedMessage: NSAttributedString) {
        
        let screenBounds = UIScreen.main.bounds.size
        
        let estimatedSize = CGSize(width: screenBounds.width/3, height: screenBounds.height/3)
        
        let label = Toaster.label(attributedMessage, size: estimatedSize)
        label.frame.origin = CGPoint(x: offset, y: offset)
        
        self.init(frame: CGRect(origin: topLeftCorner, size: label.frame.insetBy(dx: -offset, dy: -offset).size))
        
        self.addSubview(label)
    }
    
    convenience init(center: CGPoint, attributedMessage: NSAttributedString) {
        
        let screenBounds = UIScreen.main.bounds.size
        
        let estimatedSize = CGSize(width: screenBounds.width/3, height: screenBounds.height/3)
        
        let label = Toaster.label(attributedMessage, size: estimatedSize)
        label.frame.origin = CGPoint(x: offset, y: offset)
        
        let origin = CGPoint(x: center.x - label.frame.width/2, y: center.y - label.frame.height/2)
        
        self.init(frame: CGRect(origin: origin, size: label.frame.insetBy(dx: -offset, dy: -offset).size))
        
        self.addSubview(label)
    }
    
    override fileprivate init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.autoresizingMask = ([.flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleBottomMargin])
        
        self.layer.cornerRadius = 10.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 4.0
        self.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate class func label(_ message: String, size: CGSize) -> UILabel {
        
        let label = UILabel(frame: CGRect(origin: CGPoint.zero, size: size))
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = NSTextAlignment.center
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.clear
        label.text = message
        label.sizeToFit()
        
        return label
    }
    
    fileprivate class func label(_ message: NSAttributedString, size: CGSize) -> UILabel {
        
        let label = UILabel(frame: CGRect(origin: CGPoint.zero, size: size))
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.backgroundColor = UIColor.clear
        label.attributedText = message
        label.sizeToFit()
        
        return label
    }
    
    fileprivate func hideToaster() {
        
        let defaultDuration: TimeInterval = 0.7
        
        UIView.animate(withDuration: defaultDuration, animations: { [weak self] () -> Void in
            
            self?.alpha = 0
            
        }, completion: { [weak self] (finished) -> Void in
            
            if let strongSelf = self {
                
                strongSelf.removeFromSuperview()
            }
        }) 
    }
}

public extension UIView {
    
    public func showToaster(withMessage message: String, center: CGPoint, duration: TimeInterval = 2.0) {
        
        let toaster = Toaster(center: center, message: message)
        toaster.duration = duration
        
        self.addSubview(toaster)
    }
    
    public func showToaster(withMessage message: String, topLeftCorner: CGPoint, duration: TimeInterval = 2.0) {
        
        let toaster = Toaster(topLeftCorner: topLeftCorner, message: message)
        toaster.duration = duration
        
        self.addSubview(toaster)
    }
    
    public func showToaster(withAttributedMessage attributedMessage: NSAttributedString, topLeftCorner: CGPoint, duration: TimeInterval = 2.0) {
        
        let toaster = Toaster(topLeftCorner: topLeftCorner, attributedMessage: attributedMessage)
        toaster.duration = duration
        
        self.addSubview(toaster)
    }
    
    public func showToaster(withAttributedMessage attributedMessage: NSAttributedString, center: CGPoint, duration: TimeInterval = 2.0) {
        
        let toaster = Toaster(center: center, attributedMessage: attributedMessage)
        toaster.duration = duration
        
        self.addSubview(toaster)
    }
}
