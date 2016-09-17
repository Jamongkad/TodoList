//
//  UIView+fadeIn.swift
//  TodoList
//
//  Created by Mathew Wong on 17/09/2016.
//  Copyright © 2016 YidgetSoft. All rights reserved.
//

import UIKit

public extension UIView {
    func fadeIn(duration: NSTimeInterval = 1.0, callback: (() -> Void)? = nil) {
        UIView.animateWithDuration(duration) { 
            self.alpha = 1.0
            if((callback) != nil) {
                callback!()
            }
        }
    }
    
    func fadeOut(duration: NSTimeInterval = 1.0, callback: (() -> Void)? = nil) {
        UIView.animateWithDuration(duration) { 
            self.alpha = 0.0
            if((callback) != nil) {
                callback!()
            }
        }
    }
}