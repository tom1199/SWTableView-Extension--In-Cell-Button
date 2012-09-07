//
//  DemoTableView.h
//  InCellButtonTableViewDemo
//
//  Created by Tang Han, Tom on 7/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "THInCellButtonTableView.h"
#import "DemoTableViewCell.h"
@interface DemoTableView : THInCellButtonTableView<SWTableViewDataSource> {
    
}
@property (nonatomic,retain) NSArray *data;
+(id)viewWithSourceData:(NSArray *)aData andDelegate:(id<InCellButtonTableViewDelegate>)delegate;
-(id)initWithSourceData:(NSArray *)aData andDelegate:(id<InCellButtonTableViewDelegate>)delegate;
@end
