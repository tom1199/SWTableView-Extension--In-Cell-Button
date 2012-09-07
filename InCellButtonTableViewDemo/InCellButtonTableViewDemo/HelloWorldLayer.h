//
//  HelloWorldLayer.h
//  InCellButtonTableViewDemo
//
//  Created by Tang Han, Tom on 7/9/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


#import "cocos2d.h"
#import "DemoTableView.h"

@interface HelloWorldLayer : CCLayer <InCellButtonTableViewDelegate>
{
    DemoTableView *_tableView;
}

+(CCScene *) scene;

@end
