//
//  UIExtensions.swift
//  Pitch Perfect
//
//  Created by Hasan Abdulhamid on 2/11/16.
//  Copyright © 2016 Hasan Abdulhamid. All rights reserved.
//
//  This is an extention for fading the recording... UILabel in RecordSoundsViewController
//
//  Source: https://github.com/andrewcbancroft/SwiftFadeAnimations/blob/master/UIViewFadeExtensions/UIViewExtensions.swift
//

import Foundation
import UIKit

extension UIView {
    func fadeIn(duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animateWithDuration(duration, delay: delay, options: [UIViewAnimationOptions.CurveEaseIn, UIViewAnimationOptions.Repeat], animations: {
            self.alpha = 1.0
            }, completion: completion)	}
    
    func fadeOut(duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animateWithDuration(duration, delay: delay, options: [UIViewAnimationOptions.CurveEaseIn, UIViewAnimationOptions.Repeat], animations: {
            self.alpha = 0.0
            }, completion: completion)
    }
}