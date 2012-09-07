//
//  DemoTableView.m
//  InCellButtonTableViewDemo
//
//  Created by Tang Han, Tom on 7/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DemoTableView.h"

@implementation DemoTableView
+(id)viewWithSourceData:(NSArray *)aData andDelegate:(id<InCellButtonTableViewDelegate>)delegate
{
    return [[[self alloc]initWithSourceData:aData andDelegate:delegate]autorelease];
}

-(void)dealloc
{
    self.data = nil;
    [super dealloc];
}

-(id)initWithSourceData:(NSArray *)aData andDelegate:(id<InCellButtonTableViewDelegate>)delegate
{
    CGSize viewSize = CGSizeMake(300,250);
    self = [super initWithViewSize:viewSize container:nil];
    if (self) {
        _data = [aData retain];
        self.contentOffset = CGPointMake(0, 0);
        self.direction = SWScrollViewDirectionVertical;
        self.dataSource = self;
        self.delegate = delegate;
        self.bounces = YES;
        self.verticalFillOrder = SWTableViewFillTopDown;
    }
    return self;
}

#pragma mark -
#pragma mark TableView DataSource

-(Class)cellClassForTable:(SWTableView *)table {
    return [DemoTableViewCell class];
}

-(SWTableViewCell *)table:(SWTableView *)table cellAtIndex:(NSUInteger)idx
{
    DemoTableViewCell *cell;
    
    cell = (DemoTableViewCell *)[table dequeueCell];
    if (!cell) {
        cell = [DemoTableViewCell node];
    }
    cell.title = [NSString stringWithFormat:@"%d",[[self.data objectAtIndex:idx]intValue]];
    cell.inCellButton.position = ccp(200,20);

    return cell;
}
-(CGSize)cellSizeForTable:(SWTableView *)table
{
    return [DemoTableViewCell cellSize];
}

-(NSUInteger)numberOfCellsInTableView:(SWTableView *)table {
    return [self.data count];
}

@end
