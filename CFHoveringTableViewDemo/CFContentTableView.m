//
//  CFContentTableView.m
//  CFHoveringTableViewDemo
//
//  Created by 于传峰 on 16/9/10.
//  Copyright © 2016年 于传峰. All rights reserved.
//

#import "CFContentTableView.h"
#import "MJRefresh.h"

@interface CFContentTableView ()<UITableViewDataSource>


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
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 结束刷新
                [self.mj_header endRefreshing];
            });
        }];
        self.mj_header.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)dealloc
{
    
}


- (void)didMoveToWindow
{
    [super didMoveToWindow];
}



- (void)setContentOffset:(CGPoint)contentOffset
{

    if (self.window)
    {
        [super setContentOffset:contentOffset];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableView.tag * 10;
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
