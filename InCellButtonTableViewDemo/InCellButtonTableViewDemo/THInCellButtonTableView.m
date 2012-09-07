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
        
        //check if touch on button
        if ([cell isKindOfClass:[THInCellButtonTableViewCell class]]) {
            didTouchOnButton = [(THInCellButtonTableViewCell *)cell isInCellButtonContainsTouch:touch];
        }
        
        if (cell) {
            if (didTouchOnButton) {
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
@end
