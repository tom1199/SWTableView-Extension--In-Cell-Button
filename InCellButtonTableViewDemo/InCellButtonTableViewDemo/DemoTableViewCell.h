//
//  DemoTableViewCell.h
//  InCellButtonTableViewDemo
//
//  Created by Tang Han, Tom on 7/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "THInCellButtonTableViewCell.h"
@interface DemoTableViewCell : THInCellButtonTableViewCell {
@private
    CCLabelTTF *_titleLabel;
    CCSprite *_bgSprite;
}
@property (nonatomic,retain) NSString *title;

+ (CGSize)cellSize;
@end
