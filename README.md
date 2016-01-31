# Toaster
A simple toaster (like the Toaster widget in Android).

Include Toater.swift in your project.
Run:

`self.view.showToasterWithMessage("Tap to hide annoying view.", center: CGPointMake(200, 200))`

where `center` is a center of `Toaster`.

`self.view.showToasterWithMessage("Tap to hide annoying view.", topLeftCorner: CGPointMake(200, 200))`

where `topLeftCorner` is a top left corner of `Toaster`.

`let attributedString = NSAttributedString(string: "Tap to hide annoying view.", attributes: [NSBackgroundColorAttributeName: UIColor.blueColor(), NSFontAttributeName: UIFont(name: "Helvetica", size: 20)!])`

`self.view.showToasterWithAttributedMessage(attributedString, topLeftCorner: CGPoint(x: 200, y: 200))`

where `attributedString` is a string with custom attributes.


![Alt text](https://raw.githubusercontent.com/NSSimpleApps/Toaster/master/Toaster/Toaster.gif)
