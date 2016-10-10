//
//  YZJMineTitleBar.h
//  CaviarOC
//
//  Created by 于传峰 on 16/8/17.
//  Copyright © 2016年 Apple. All rights reserved.
//  Abstract:我的钱包 贡献榜 上方的横条

#import <UIKit/UIKit.h>

@interface CFTitleBar : UIView

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, copy)  void(^buttonSelected)(NSInteger index);

@end
