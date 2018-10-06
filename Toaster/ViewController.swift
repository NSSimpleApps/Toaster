//
//  ViewController.swift
//  Toaster
//
//  Created by NSSimpleApps on 23.04.15.
//  Copyright (c) 2015 NSSimpleApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toastAtCustomTopLeftCorner() {
        
        self.view.showToaster(withMessage: "Tap to hide annoying view.", topLeftCorner: CGPoint(x: 200, y: 200))
    }
    
    @IBAction func toastAtCustomCenter() {
        
        self.view.showToaster(withMessage: "Tap to hide annoying view.", center: CGPoint(x: 200, y: 200))
    }
    
    @IBAction func toastWithAttributedString() {
        
        let attributedString = NSAttributedString(string: "Tap to hide annoying view.", attributes: [.backgroundColor: UIColor.blue, .font: UIFont(name: "Helvetica", size: 20)!])
        
        self.view.showToaster(withAttributedMessage: attributedString, topLeftCorner: CGPoint(x: 200, y: 200))
    }
}

