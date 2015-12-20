//
//  DJCustomTransformLable.m
//  Sector (饼状图)
//
//  Created by dajie on 15/12/20.
//  Copyright © 2015年 dajie. All rights reserved.
//

#import "DJCustomTransformLable.h"

@implementation DJCustomTransformLable

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setUpUI
{
    UILabel *lable = [[UILabel alloc] init];
    [self addSubview:lable];
    self.transformLable = lable;
    
    UIView *tipView = [[UIView alloc] init];
    [self addSubview:tipView];
    self.tipView = tipView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.transformLable sizeToFit];
    self.transformLable.top = 0;
    self.transformLable.left = - self.transformLable.width * 0.5;
    
    self.tipView.frame = CGRectMake(0, self.transformLable.bottom, 0.5, self.tipViewHeight);
}

@end
