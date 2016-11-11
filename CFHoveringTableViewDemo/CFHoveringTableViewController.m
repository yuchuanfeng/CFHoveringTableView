//
//  CFHoveringTableViewController.m
//  CFHoveringTableViewDemo
//
//  Created by 于传峰 on 16/9/10.
//  Copyright © 2016年 于传峰. All rights reserved.
//

#import "CFHoveringTableViewController.h"
#import "CFContentTableView.h"
#import "CFTitleBar.h"
#import "NextTableViewController.h"
#import "CFContentScrollView.h"
#import "CFContentHeadView.h"



@interface CFHoveringTableViewController ()<UIScrollViewDelegate, UITableViewDelegate>
@property (nonatomic, weak) CFContentScrollView *scrollView;
@property (nonatomic, weak) CFContentTableView *table1;
@property (nonatomic, weak) CFContentTableView *table2;
@property (nonatomic, weak) CFContentTableView *table3;

@property (nonatomic, strong) UIView *tableViewHeadView;

@property (nonatomic, weak) UIView *headBackView;

@property (nonatomic, weak) CFTitleBar *titleBarView;

@property (nonatomic, assign) CGFloat headViewHeight;
@end

@implementation CFHoveringTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    self.view.clipsToBounds = YES;
    
    self.headViewHeight = HeadViewHeight;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupContentView];
    
    [self setupHeadView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupContentView
{
    // scrollView
    CFContentScrollView* scrollView = [[CFContentScrollView alloc] init];
    scrollView.delaysContentTouches = NO;
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor redColor];
    self.scrollView = scrollView;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(kScreenWidth * 3, 0);
//    [scrollView makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
    
    UIView* headView = [[UIView alloc] init];
    headView.frame = CGRectMake(0, 0, 0, self.headViewHeight + TitleHeight);
    self.tableViewHeadView = headView;
    headView.backgroundColor = [UIColor greenColor];
    
    
    CFContentTableView* table1 = [[CFContentTableView alloc] init];
    table1.tag = 1;
    table1.delegate = self;
    self.table1 = table1;
    table1.tableHeaderView = headView;
    [scrollView addSubview:table1];
    [table1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView);
        make.width.equalTo(kScreenWidth);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    
    CFContentTableView* table2 = [[CFContentTableView alloc] init];
    table2.tag = 2;
    table2.delegate = self;
    self.table2 = table2;
    table2.tableHeaderView = headView;
    [scrollView addSubview:table2];
    [table2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView).offset(kScreenWidth);
        make.width.equalTo(table1);
        make.top.bottom.equalTo(table1);
    }];
    
    CFContentTableView* table3 = [[CFContentTableView alloc] init];
    table3.tag = 3;
    table3.delegate = self;
    self.table3 = table3;
    table3.tableHeaderView = headView;
    [scrollView addSubview:table3];
    [table3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView).offset(kScreenWidth*2);
        make.width.equalTo(table1);
        make.top.bottom.equalTo(table1);
    }];
    
}

- (void)setupHeadView
{
    UIView* headBackView = [[CFContentHeadView alloc] init];
    headBackView.backgroundColor = [UIColor blueColor];
//    headBackView.userInteractionEnabled = NO;
    headBackView.frame = CGRectMake(0, 0, kScreenWidth, self.headViewHeight + TitleHeight);
    [self.view addSubview:headBackView];
    self.headBackView = headBackView;
    
    UIButton* backButton = [[UIButton alloc] init];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [headBackView addSubview:backButton];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [backButton makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headBackView);
    }];
    
    CFTitleBar* titleBarView = [[CFTitleBar alloc] init];
    //    titleBarView.frame = CGRectMake(0, HeadHeight, kScreenWidth, TitleHeight);
    [headBackView addSubview:titleBarView];
    self.titleBarView = titleBarView;
    titleBarView.backgroundColor = [UIColor whiteColor];
    [titleBarView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(headBackView);
        make.bottom.equalTo(headBackView.mas_bottom);
        make.height.equalTo(TitleHeight);
    }];
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    titleBarView.titles = @[@" 新闻 ", @" 热点 ", @" 关注 "];
    titleBarView.selectedIndex = 0;
    titleBarView.buttonSelected = ^(NSInteger index){
        [weakSelf.scrollView setContentOffset:CGPointMake(kScreenWidth * index, 0) animated:YES];
    };
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView)
    {        
        CGFloat contentOffsetX = scrollView.contentOffset.x;
        
        NSInteger pageNum = contentOffsetX / kScreenWidth + 0.5;
        
        self.titleBarView.selectedIndex = pageNum;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView || !scrollView.window)
    {
        return;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat originY = 0;
    CGFloat otherOffsetY = 0;
    if (offsetY <= self.headViewHeight)
    {
        originY = -offsetY;
        if (offsetY < 0)
        {
            otherOffsetY = 0;
        }else{
            otherOffsetY = offsetY;
        }
    }else{
        originY = -self.headViewHeight;
        otherOffsetY = self.headViewHeight;
    }
    self.headBackView.frame = CGRectMake(0, originY, kScreenWidth, self.headViewHeight+TitleHeight);
    
    for ( int i = 0; i<self.titleBarView.titles.count; i++ )
    {
        if (i != self.titleBarView.selectedIndex)
        {
            UITableView* contentView = self.scrollView.subviews[i];
            CGPoint offset = CGPointMake(0, otherOffsetY);
            if ([contentView isKindOfClass:[UITableView class]])
            {
                if (contentView.contentOffset.y < self.headViewHeight || offset.y < self.headViewHeight)
                {
                    [contentView setContentOffset:offset animated:NO];
                    self.scrollView.offset = offset;
                }
            }
        }
    }
    
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NextTableViewController* VC = [[NextTableViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)back:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
