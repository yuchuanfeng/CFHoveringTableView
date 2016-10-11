//
//  CFContentHeadView.m
//  CFHoveringTableViewDemo
//
//  Created by 于传峰 on 2016/10/11.
//  Copyright © 2016年 于传峰. All rights reserved.
//

#import "CFContentHeadView.h"

@implementation CFContentHeadView


-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    
    UIView* view = [super hitTest:point withEvent:event];
    
    if ([view isKindOfClass:[UIButton class]])
    {
        return view;
    }
    
    return nil;
}



@end
