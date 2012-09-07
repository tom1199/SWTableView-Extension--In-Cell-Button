//
//  THInCellButtonTableView.m
//  InCellButtonTableViewDemo
//
//  Created by Tang Han, Tom on 7/9/12.
//

#import "THInCellButtonTableView.h"

@interface SWScrollView()
@property (nonatomic, assign) BOOL    touchMoved_;
@property (nonatomic, retain) CCLayer *container_;
@property (nonatomic, assign) CGPoint touchPoint_;
@end

@interface SWTableView ()
- (NSUInteger)_indexFromOffset:(CGPoint)offset;
- (SWTableViewCell *)_cellWithIndex:(NSUInteger)cellIndex;
@end

@implementation THInCellButtonTableView
#pragma mark -
#pragma mark Touch events
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if (!self.visible) {
        return NO;
    }
    CGRect frame;
    
    frame = CGRectMake(self.position.x, self.position.y, viewSize_.width, viewSize_.height);
    //dispatcher does not know about clipping. reject touches outside visible bounds.
    if ([touches_ count] > 2 ||
        touchMoved_          ||
        !CGRectContainsPoint(frame, [container_ convertToWorldSpace:[container_ convertTouchToNodeSpace:touch]])) {
        return NO;
    }
	
    if (![touches_ containsObject:touch]) {
        [touches_ addObject:touch];
    }
    if ([touches_ count] == 1) { // scrolling
        touchPoint_     = [self convertTouchToNodeSpace:touch];
        touchMoved_     = NO;
        isDragging_     = YES; //dragging started
        scrollDistance_ = ccp(0.0f, 0.0f);
        touchLength_    = 0.0f;
        
        //compute selected cell
        NSUInteger        index;
        SWTableViewCell   *cell;
        CGPoint           point;
        BOOL              didTouchOnButton = NO;
        
        point = [container_ convertTouchToNodeSpace:touch];
        if (vordering_ == SWTableViewFillTopDown) {
            CGSize cellSize = [self.dataSource cellSizeForTable:self];
            point.y -= cellSize.height;
        }
        index = [self _indexFromOffset:point];
        cell  = [self _cellWithIndex:index];
        
        //check if touch on button
        if ([cell isKindOfClass:[THInCellButtonTableViewCell class]]) {
            didTouchOnButton = [(THInCellButtonTableViewCell *)cell isInCellButtonContainsTouch:touch];
        }
        
        if (didTouchOnButton && [(THInCellButtonTableViewCell *)cell inCellButton].isEnabled) {
            [[(THInCellButtonTableViewCell *)cell inCellButton] selected];
        }
        
    } else if ([touches_ count] == 2) {
        touchPoint_  = ccpMidpoint([self convertTouchToNodeSpace:[touches_ objectAtIndex:0]],
                                   [self convertTouchToNodeSpace:[touches_ objectAtIndex:1]]);
        touchLength_ = ccpDistance([container_ convertTouchToNodeSpace:[touches_ objectAtIndex:0]],
                                   [container_ convertTouchToNodeSpace:[touches_ objectAtIndex:1]]);
        isDragging_  = NO;
    }
    return YES;
    
}
-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    [super ccTouchMoved:touch withEvent:event];
    
    if ([touches_ containsObject:touch] && [touches_ count] == 1 && isDragging_) {
        //update in cell button
        NSUInteger        index;
        SWTableViewCell   *cell;
        CGPoint           point;
        BOOL              didTouchOnButton = NO;
        
        point = [container_ convertTouchToNodeSpace:touch];
        if (vordering_ == SWTableViewFillTopDown) {
            CGSize cellSize = [self.dataSource cellSizeForTable:self];
            point.y -= cellSize.height;
        }
        index = [self _indexFromOffset:point];
        cell  = [self _cellWithIndex:index];
        
        //check if touch on button
        if ([cell isKindOfClass:[THInCellButtonTableViewCell class]]) {
            didTouchOnButton = [(THInCellButtonTableViewCell *)cell isInCellButtonContainsTouch:touch];
        }
        
        if (didTouchOnButton && [(THInCellButtonTableViewCell *)cell inCellButton].isEnabled && [(THInCellButtonTableViewCell *)cell inCellButton].isSelected) {
            [[(THInCellButtonTableViewCell *)cell inCellButton] unselected];
        }

    }
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if (!self.visible) {
        return;
    }
    if ([touches_ count] == 1 && !self.touchMoved_) {
        NSUInteger        index;
        SWTableViewCell   *cell;
        CGPoint           point;
        BOOL              didTouchOnButton = NO;
        
        point = [container_ convertTouchToNodeSpace:touch];
        if (vordering_ == SWTableViewFillTopDown) {
            CGSize cellSize = [self.dataSource cellSizeForTable:self];
            point.y -= cellSize.height;
        }
        index = [self _indexFromOffset:point];
        cell  = [self _cellWithIndex:index];
        
        //update in cell button
        if ([cell isKindOfClass:[THInCellButtonTableViewCell class]]) {
            didTouchOnButton = [(THInCellButtonTableViewCell *)cell isInCellButtonContainsTouch:touch];
        }
        
        if (cell) {
            if (didTouchOnButton && [(THInCellButtonTableViewCell *)cell inCellButton].isEnabled) {
                [[(THInCellButtonTableViewCell *)cell inCellButton] unselected];
                [self.delegate table:self buttonTouchedInCell:cell];
            }else {
                [self.delegate table:self cellTouched:cell];
            }
        }
    }
    
    //From SWScrollView
    if ([touches_ containsObject:touch]) {
        if (touchMoved_) {
            [self schedule:@selector(deaccelerateScrolling:)];
        }
        [touches_ removeObject:touch];
    }
    if ([touches_ count] == 0) {
        isDragging_ = NO;
        touchMoved_ = NO;
    }
    
}
-(void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
    [super ccTouchCancelled:touch withEvent:event];
    
    //update in cell button
    NSUInteger        index;
    SWTableViewCell   *cell;
    CGPoint           point;
    BOOL              didTouchOnButton = NO;
    
    point = [container_ convertTouchToNodeSpace:touch];
    if (vordering_ == SWTableViewFillTopDown) {
        CGSize cellSize = [self.dataSource cellSizeForTable:self];
        point.y -= cellSize.height;
    }
    index = [self _indexFromOffset:point];
    cell  = [self _cellWithIndex:index];
    
    //check if touch on button
    if ([cell isKindOfClass:[THInCellButtonTableViewCell class]]) {
        didTouchOnButton = [(THInCellButtonTableViewCell *)cell isInCellButtonContainsTouch:touch];
    }
    
    if (didTouchOnButton && [(THInCellButtonTableViewCell *)cell inCellButton].isEnabled && [(THInCellButtonTableViewCell *)cell inCellButton].isSelected) {
        [[(THInCellButtonTableViewCell *)cell inCellButton] unselected];
    }
}
@end
