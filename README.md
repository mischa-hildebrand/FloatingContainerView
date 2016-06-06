# FloatingContainerView

This `UIView` subclass lays out its subviews in a floating fashion.
It iterates through all subviews and positions each view next to the previous view
with a horizontal spacing as specified by the `columnSpacing` property.
If the view doesn't fit into the same row because its width would exceed
the container bounds it floats into the next row and so on.

## Usage:

You can add the subviews either in Interface Builder or in code.
Either way make sure that:
  - either the `intrinsicContentSize` or the `frame` is set for all subviews
  - the floating view container has a fixed width
    (either set through constraints or manual positioning)  

You can control the horizontal and vertical spacing
through the corresponding properties `columnSpacing` and `rowSpacing`.

![Screenshot](https://github.com/mischa-hildebrand/FloatingContainerView/blob/master/FloatingContainerViewScreenshot_nonRetina.png)
