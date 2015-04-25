//
//  ViewController.swift
//  Toaster
//
//  Created by NSSimpleApps on 23.04.15.
//  Copyright (c) 2015 NSSimpleApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customView: UIView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func showToaster() {
        
        Toaster(frame: CGRectMake(100, 100, 100, 100)).show("Toaster. Tap to hide annoying view.")
    }

    @IBAction func showToasterWithDuration() {
        
        Toaster(frame: CGRectMake(100, 100, 100, 100)).show("Toaster. Tap to hide annoying view", duration: 1.0)
    }
    
    @IBAction func showToasterOnView() {
        
        self.customView.showToaster(CGRectMake(100, 100, 100, 100), message: "Toaster. Tap to hide annoying view")
    }
}

