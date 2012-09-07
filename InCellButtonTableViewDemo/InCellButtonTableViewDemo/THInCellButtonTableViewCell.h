//
//  THInCellButtonTableViewCell.h
//  InCellButtonTableViewDemo
//
//  Created by Tang Han, Tom on 7/9/12.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SWTableViewCell.h"

@interface THInCellButtonTableViewCell : SWTableViewCell {
    
}
@property (nonatomic,readwrite,assign) CCMenuItemSprite *inCellButton;

- (BOOL)isInCellButtonContainsTouch:(UITouch *)touch;
@end
