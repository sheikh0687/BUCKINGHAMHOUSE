//
//  UIView+Extension.swift
//  BUCKINGHAMHOUSE
//
//  Created by Techimmense Software Solutions on 22/09/23.
//

import Foundation

public extension UIView {
    /**
     Captures view and subviews in an image
     */
    func snapshotViewHierarchy() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let copied = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return copied
    }
}
