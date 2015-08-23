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

    @IBAction func toastAtCustomPosition() {
        
        Toaster(toasterPosition: .LeftXTopY).show("Tap to hide annoying view.")
    }
    
    @IBAction func toastAtCustomCenter() {
        
        Toaster(center: CGPointMake(200, 200)).show("Tap to hide annoying view.")
    }
    
    @IBAction func toastAtCustomTopLeftCorner() {
        
        Toaster(topLeftCorner: CGPointMake(200, 200)).show("Tap to hide annoying view.")
    }
    
    @IBAction func toastInView() {
        
        self.customView.showToaster("Tap to hide annoying view", center: self.customView.center)
    }
}

