//
//  HelloWorldLayer.m
//  InCellButtonTableViewDemo
//
//  Created by Tang Han, Tom on 7/9/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import "HelloWorldLayer.h"

@implementation HelloWorldLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
    HelloWorldLayer *layer = [HelloWorldLayer node];
	[scene addChild: layer];
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	if( (self=[super init])) {
		self.anchorPoint = CGPointZero;
        
        CCMenuItemFont *btnToggleEnable = [CCMenuItemFont itemFromString:@"Toggle" target:self selector:@selector(togglePressed:)];
        btnToggleEnable.position = ccp(400,self.contentSize.height/2);
        CCMenu *menu = [CCMenu menuWithItems:btnToggleEnable, nil];
        menu.anchorPoint = CGPointZero;
        menu.position = CGPointZero;
        [self addChild:menu];
        
        [self createTable];
	}
	return self;
}
- (void)togglePressed:(id)sender {
    _tableView.isTouchEnabled = !_tableView.isTouchEnabled;
}
- (void)createTable {
    NSArray *data = @[@1,@2,@3,@4,@5,@6,@7,@8,@9];
    _tableView = [DemoTableView viewWithSourceData:data andDelegate:self];
    _tableView.position = ccp(50,50);
    [self addChild:_tableView];
    [_tableView reloadData];
}

#pragma mark -
#pragma mark InCellButtonTableViewDelegate
- (void)table:(SWTableView *)table cellTouched:(SWTableViewCell *)cell {
    NSLog(@"touch on cell at index %d",cell.idx);
}
- (void)table:(SWTableView *)table buttonTouchedInCell:(SWTableViewCell *)cell {
    NSLog(@"touch on button at index %d",cell.idx);
}
@end
