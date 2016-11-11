//
//  CFContentScrollView.m
//  CFHoveringTableViewDemo
//
//  Created by 于传峰 on 2016/10/10.
//  Copyright © 2016年 于传峰. All rights reserved.
//

#import "CFContentScrollView.h"

@implementation CFContentScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.clipsToBounds = NO;
    }
    return self;
}

//-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
//
//    
//    return YES;
//}

- (void)setOffset:(CGPoint)offset
{
    _offset = offset;
    NSLog(@"%@", NSStringFromCGPoint(offset));
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    
    UIView* view = [super hitTest:point withEvent:event];
    BOOL hitHead = point.y < (HeadViewHeight - self.offset.y);
    if (hitHead || !view)
    {
        NSLog(@"no view");
        self.scrollEnabled = NO;
        if (!view)
        {
            for (UIView* subView in self.subviews) {
                if (subView.frame.origin.x == self.contentOffset.x)
                {
                    view = subView;
                }
            }
        }
        return view;
    }else{
        NSLog(@"view = %@", view);
        self.scrollEnabled = YES;
        return view;
        
    }
}


@end
