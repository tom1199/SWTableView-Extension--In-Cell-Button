//
//  THInCellButtonTableView.h
//  InCellButtonTableViewDemo
//
//  Created by Tang Han, Tom on 7/9/12.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SWTableView.h"
#import "THInCellButtonTableViewCell.h"

@protocol InCellButtonTableViewDelegate <SWTableViewDelegate>
- (void)table:(SWTableView *)table buttonTouchedInCell:(SWTableViewCell *)cell;
@end

@interface THInCellButtonTableView : SWTableView {
    
}
//override SWTableView delegate
@property (nonatomic,assign) id<InCellButtonTableViewDelegate>delegate;
@end
