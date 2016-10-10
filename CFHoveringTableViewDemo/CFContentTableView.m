//
//  CFContentTableView.m
//  CFHoveringTableViewDemo
//
//  Created by 于传峰 on 16/9/10.
//  Copyright © 2016年 于传峰. All rights reserved.
//

#import "CFContentTableView.h"

@interface CFContentTableView ()<UITableViewDataSource>

@property (nonatomic, weak) UIWindow *nextWindow;

@end

@implementation CFContentTableView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.dataSource = self;
        self.backgroundColor = KRandomColor;
    }
    return self;
}

- (void)dealloc
{
    
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    self.nextWindow = newWindow;
}

- (void)setContentOffset:(CGPoint)contentOffset
{
    if (self.nextWindow)
    {
        [super setContentOffset:contentOffset];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arc4random_uniform(30) + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"contentCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"contentCell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"content - %zd", indexPath.row];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}


#pragma mark - Event Response

#pragma mark - Private Method

#pragma mark - Setters And Getters

@end
