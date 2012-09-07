//
//  THInCellButtonTableViewCell.m
//  InCellButtonTableViewDemo
//
//  Created by Tang Han, Tom on 7/9/12.
//

#import "THInCellButtonTableViewCell.h"


@implementation THInCellButtonTableViewCell
#pragma mark - 
#pragma mark Setter
- (CGRect)buttonRect {
    return CGRectMake(self.inCellButton.position.x - self.inCellButton.contentSize.width * self.inCellButton.anchorPoint.x,
                      self.inCellButton.position.y - self.inCellButton.contentSize.height * self.inCellButton.anchorPoint.y,
                      self.inCellButton.contentSize.width, self.inCellButton.contentSize.height);
}
- (BOOL)isInCellButtonContainsTouch:(UITouch *)touch {
    //expend touch area if button too small
    CGRect originalRect = [self buttonRect];
//    CGPoint touchAreaInset;
//    touchAreaInset.x = originalRect.size.width - MAX(originalRect.size.width, MIN_TOUCH_AREA_WIDTH);
//    touchAreaInset.y = originalRect.size.height - MAX(originalRect.size.height, MIN_TOUCH_AREA_HEIGHT);
//    CGRect expendedTouchRegionRect = CGRectInset(originalRect, touchAreaInset.x, touchAreaInset.y);
    
    return CGRectContainsPoint(/*expendedTouchRegionRect*/originalRect, [self convertTouchToNodeSpaceAR:touch]);
}
- (void)setInCellButton:(CCMenuItemSprite *)inCellButton {
    if (_inCellButton) {
        [self removeChild:_inCellButton cleanup:YES];
    }
    
    inCellButton.anchorPoint = CGPointZero;
    [self addChild:inCellButton z:100];     //make button on most upper z-layer
    _inCellButton = inCellButton;
}
@end
