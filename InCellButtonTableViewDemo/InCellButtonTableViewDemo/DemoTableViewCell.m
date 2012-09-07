//
//  DemoTableViewCell.m
//  InCellButtonTableViewDemo
//
//  Created by Tang Han, Tom on 7/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DemoTableViewCell.h"

@implementation DemoTableViewCell

static CGSize __cellSize;
+ (CGSize)cellSize {
    return CGSizeMake(250, 50);
}
- (id)init {
    self = [super init];
    if (self) {
        _bgSprite = [CCSprite spriteWithFile:@"cell.png"];
        _bgSprite.anchorPoint = CGPointZero;
        _bgSprite.position = CGPointZero;
        [self addChild:_bgSprite];
        __cellSize = _bgSprite.contentSize;
        
        
        CCMenuItemSprite *menuItem = [CCMenuItemSprite itemFromNormalSprite:[CCSprite spriteWithFile:@"button.png"]
                                                             selectedSprite:nil];
        self.inCellButton = menuItem;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    if (_title) {
        [_title release];
    }
    _title = [title retain];
    
    //update label
    if (!_titleLabel) {
        _titleLabel = [CCLabelTTF labelWithString:_title
                                         fontName:@"Marker Felt"
                                         fontSize:18];
        _titleLabel.anchorPoint = CGPointZero;
        _titleLabel.position = ccpAdd(_bgSprite.position, ccp(10,10));
        [self addChild:_titleLabel];
    }else {
        [_titleLabel setString:_title];
    }
}
@end
