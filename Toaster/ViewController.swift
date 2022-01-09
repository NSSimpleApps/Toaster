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
        
        self.view.backgroundColor = .white
        
        let toastAtCustomTopLeftCornerButton = UIButton(type: .system)
        toastAtCustomTopLeftCornerButton.setTitle("Toast at custom top left corner", for: .normal)
        toastAtCustomTopLeftCornerButton.addTarget(self, action: #selector(self.toastAtCustomTopLeftCorner(_:)), for: .touchUpInside)
        toastAtCustomTopLeftCornerButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(toastAtCustomTopLeftCornerButton)
        toastAtCustomTopLeftCornerButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        toastAtCustomTopLeftCornerButton.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        toastAtCustomTopLeftCornerButton.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        let toastAtCustomCenterButton = UIButton(type: .system)
        toastAtCustomCenterButton.setTitle("Toast at custom center", for: .normal)
        toastAtCustomCenterButton.addTarget(self, action: #selector(self.toastAtCustomCenter(_:)), for: .touchUpInside)
        toastAtCustomCenterButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(toastAtCustomCenterButton)
        toastAtCustomCenterButton.topAnchor.constraint(equalTo: toastAtCustomTopLeftCornerButton.bottomAnchor, constant: 16).isActive = true
        toastAtCustomCenterButton.leftAnchor.constraint(equalTo: toastAtCustomTopLeftCornerButton.leftAnchor).isActive = true
        toastAtCustomCenterButton.rightAnchor.constraint(equalTo: toastAtCustomTopLeftCornerButton.rightAnchor).isActive = true
        
        let toastWithAttributedStringButton = UIButton(type: .system)
        toastWithAttributedStringButton.setTitle("Toast with attributed string", for: .normal)
        toastWithAttributedStringButton.addTarget(self, action: #selector(self.toastAtCustomCenter(_:)), for: .touchUpInside)
        toastWithAttributedStringButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(toastWithAttributedStringButton)
        toastWithAttributedStringButton.topAnchor.constraint(equalTo: toastAtCustomCenterButton.bottomAnchor, constant: 16).isActive = true
        toastWithAttributedStringButton.leftAnchor.constraint(equalTo: toastAtCustomCenterButton.leftAnchor).isActive = true
        toastWithAttributedStringButton.rightAnchor.constraint(equalTo: toastAtCustomCenterButton.rightAnchor).isActive = true
    }

    @objc func toastAtCustomTopLeftCorner(_ sender: UIButton) {
        self.view.showToaster(withMessage: "Tap to hide annoying view.", topLeftCorner: CGPoint(x: 200, y: 200))
    }
    
    @objc func toastAtCustomCenter(_ sender: UIButton) {
        self.view.showToaster(withMessage: "Tap to hide annoying view.", center: CGPoint(x: 200, y: 200))
    }
    
    @objc func toastWithAttributedString(_ sender: UIButton) {
        let attributedString = NSAttributedString(string: "Tap to hide annoying view.", attributes: [.backgroundColor: UIColor.blue, .font: UIFont(name: "Helvetica", size: 20)!])
        
        self.view.showToaster(withAttributedMessage: attributedString, topLeftCorner: CGPoint(x: 200, y: 200))
    }
}

