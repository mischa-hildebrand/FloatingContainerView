//
//  FloatingViewContainer.swift
//
//  Created by Mischa Hildebrand on 05/06/16.
//  Copyright © 2016 Mischa Hildebrand. All rights reserved.
//  http://www.mischa-hildebrand.de
//

import UIKit

/// This `UIView` subclass lays out its subviews in a floating fashion.
/// It iterates through all subviews and positions each view next to the previous view
/// with a horizontal spacing as specified by the `columnSpacing` property.
/// If the view doesn't fit into the same row because its width would exceed
/// the container bounds it floats into the next row and so on.
///
/// # Usage:
///
///   You can add the subviews either in Interface Builder or in code.
///   Either way make sure that:
///   - either the `intrinsicContentSize` or the `frame` is set for all subviews
///   - the floating view container has a fixed width
///     (either set through constraints or manual positioning)
///
///   You can control the horizontal and vertical spacing
///   through the corresponding properties `columnSpacing` and `rowSpacing`.
///
class FloatingViewContainer: UIView {
    
    /// The spacing between to rows of subviews
    @IBInspectable var rowSpacing: CGFloat = 0
    
    /// The spacing between two columns of subviews
    @IBInspectable var columnSpacing: CGFloat = 0
    
    /// The intrinsic size of the view.
    /// This variable is updated in each layout pass.
    private var intrinsicHeight: CGFloat = 0
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        // The maximal width of a row. When reached or exceeded
        // the current subview will float to the next row.
        let maxWidth = CGRectGetWidth(self.frame)
        
        // The position to draw the current subview
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        // Create a copy of the view's subviews array
        var remainingViews = self.subviews
        
        // Iterate through all subviews and remove each subview
        // from the array after it has been positioned.
        while remainingViews.count > 0 {
            
            x = 0
            var rowHeight: CGFloat = 0
            
            while remainingViews.count > 0 {
                
                let subview = remainingViews.first
                
                if let width = self.widthForView(subview), height = self.heightForView(subview) {
                    if x + width > maxWidth {
                        // jump to new line
                        break
                    } else {
                        
                        // set frame for current subview
                        subview?.frame = CGRectMake(x, y, width, height)
                        // increment x position for next subview
                        x += width
                        x += columnSpacing
                        // update rowHeight if this view is the tallest in this row so far
                        rowHeight = max(rowHeight, height)
                    }
                }
                
                // remove subview from remaining views
                remainingViews.removeFirst()
                
            }
            
            // increment y position for next row
            y += rowHeight
            y += rowSpacing
            
        }
        
        let previousIntrinsicHeight = intrinsicContentSize().height
        intrinsicHeight = y - rowSpacing
        if intrinsicHeight != previousIntrinsicHeight {
            self.invalidateIntrinsicContentSize()
        }
        
    }
    
    override func intrinsicContentSize() -> CGSize {
        /// This view has only an intrinsic height.
        /// Its width needs to be set by its superview,
        /// either by using constraints or by manually setting its frame.
        return CGSizeMake(UIViewNoIntrinsicMetric, intrinsicHeight)
    }
    
    /**
     Computes the width of a view.
     
     - parameter view: The view for which to obtain its width
     
     - returns: The instrinsic content width of the view if it has one
                or else the view's current frame width.
                `Nil` if the view itself is nil.
     */
    func widthForView(view: UIView?) -> CGFloat? {
        if let theView = view {
            if theView.intrinsicContentSize().width == UIViewNoIntrinsicMetric {
                return theView.frame.size.width
            } else {
                return theView.intrinsicContentSize().width
            }
        } else {
            return nil
        }
    }
    
    /**
     Computes the height of a view.
     
     - parameter view: The view for which to obtain its height
     
     - returns: The instrinsic content height of the view if it has one
                or else the view's current frame width.
                `Nil` if the view itself is nil.
     */
    func heightForView(view: UIView?) -> CGFloat? {
        if let theView = view {
            if theView.intrinsicContentSize().height == UIViewNoIntrinsicMetric {
                return theView.frame.size.height
            } else {
                return theView.intrinsicContentSize().height
            }
        } else {
            return nil
        }
    }
    

}
