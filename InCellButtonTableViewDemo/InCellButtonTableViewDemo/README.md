SWTableView-Extension--In-Cell-Button
=====================================

Provide In cell button feature, differentiate cell touch and in cell button touch events

1. THInCellButtonTableView
   it is a subclass of SWTableView. By overriding the CCTargetedDispatchDelegate methods, it capable to perform additional touch location checking(if touch is located in the button) and update its delegate. It only works fine with THInCellButtonTableViewCell class or THInCellButtonTableViewCell subclass.

2. THInCellButtonTableViewCell
    It's a subclass of SWTableViewCell. It uses CCMenuItemSprite as the button to receive touch event. CCMenuItemSprite functions as usual.
    
3. InCellButtonTableViewDelegate
    This protocol is a extension of SWTableViewDelegate protocol, it add in an additional method to differentiate touch on InCellButton from touch on cell