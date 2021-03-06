# FloatingContainerView

This `UIView` subclass lays out its subviews in a floating fashion.
It iterates through all subviews and positions each view next to the previous view
with a horizontal spacing as specified by the `columnSpacing` property.
If the view doesn't fit into the same row because its width would exceed
the container bounds it floats into the next row and so on.

**Note:** If the subviews you want to display look very similar or if you want to display
a large number of subviews **you should consider using a `UICollectionView` instead**
as it will improve the performance and provide a clean data source and delegate protocol.

## Usage:

You can add the subviews either in Interface Builder or in code.
Either way make sure that:
  - either the `intrinsicContentSize` or the `frame` is set for all subviews
  - the floating view container has a fixed width
    (either set through constraints or manual positioning)  

You can control the horizontal and vertical spacing
through the corresponding properties `columnSpacing` and `rowSpacing`.  

### Important:

The subviews will be arranged *in the order in which they were added to the container*.
When you add the subviews in Interface Builder please be aware that each time you 
move a view to a new location it is internally removed from and added back to the 
container.

### Example:
  
![Screenshot](https://github.com/mischa-hildebrand/FloatingContainerView/blob/master/FloatingContainerViewScreenshot_nonRetina.png)
