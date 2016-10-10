//
//  CFContentScrollView.m
//  CFHoveringTableViewDemo
//
//  Created by 于传峰 on 2016/10/10.
//  Copyright © 2016年 于传峰. All rights reserved.
//

#import "CFContentScrollView.h"

@implementation CFContentScrollView

//-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//
//    
//    return YES;
//}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    
    UIView* view = [super hitTest:point withEvent:event];
    if (view)
    {
        NSLog(@"view");
        self.scrollEnabled = YES;
        return view;
    }else{
        NSLog(@"no view");
        self.scrollEnabled = NO;
        for (UIView* subView in self.subviews) {
            if (subView.frame.origin.x == self.contentOffset.x)
            {
                view = subView;
            }
        }
        return view;
    }
}


@end
