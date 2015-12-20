//
//  DJCustomPanCakeGraph.m
//  Sector (饼状图)
//
//  Created by dajie on 15/12/19.
//  Copyright © 2015年 dajie. All rights reserved.
//

#import "DJCustomPanCakeGraph.h"
#import "DJCustomPanCakeGraphModel.h"
#import <objc/runtime.h>

@interface DJCustomPanCakeGraph()

@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation DJCustomPanCakeGraph


/**
 *  用于纯代码
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.modelArray = [[NSMutableArray alloc] init];
    }
    return self;
}

/**
 *  用于Xib
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.modelArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    unsigned int outCount = 0;
    objc_property_t *proprotyList = class_copyPropertyList([DJCustomPanCakeGraphModel class], &outCount);
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (NSDictionary *dict in dataArray)
        {
            DJCustomPanCakeGraphModel *dataModel = [[DJCustomPanCakeGraphModel alloc] init];
            [weakSelf changeValeToModelWithDict:dict dataModel:dataModel propertyCount:outCount propertyList:proprotyList];
            [weakSelf.modelArray addObject:dataModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.isShowTipLable)
            {
                [weakSelf setUpLableWithModel:weakSelf.modelArray];
            }
            [weakSelf setNeedsDisplay];
        });
    });
}

- (void)changeValeToModelWithDict:(NSDictionary *)dict dataModel:(DJCustomPanCakeGraphModel *)dataModel propertyCount:(unsigned int)count propertyList:(objc_property_t *)propertyList
{
    for (int j = 0; j < count; j++)
    {
        NSString *keyName = [NSString stringWithFormat:@"%s", property_getName(propertyList[j])];
        [dataModel setValue:dict[keyName] forKey:keyName];
    }
}

#pragma mark - 用于绕任一点旋转
CGAffineTransform  GetCGAffineTransformRotateAroundPoint(float centerX, float centerY ,float x ,float y ,float angle)
{
    x = x - centerX;
    y = y - centerY;
    
    CGAffineTransform  trans = CGAffineTransformMakeTranslation(x, y);
    trans = CGAffineTransformRotate(trans,angle);
    trans = CGAffineTransformTranslate(trans,-x, -y);
    return trans;
}

- (void)setUpLableWithModel:(NSArray *)modelArray
{
    self.lableMagin = (self.lableMagin == 0) ? 15 : self.lableMagin;
    CGFloat startAngle = 0, lableStartAngle = 0;
    CGFloat endAngle, lableEndAngle = 0;
    float centerX = self.size.width * 0.5;
    float centerY = self.size.height * 0.5 - self.lableMagin;
    float x = self.size.width * 0.5;
    float y = self.radius * 2 + self.lableMagin;
    for (int i = 0; i < modelArray.count; i++)
    {
        DJCustomPanCakeGraphModel *dataModel = self.modelArray[i];
       CGFloat percentage = (dataModel.percentage.intValue == 0) ? dataModel.percentage.floatValue * 100 :dataModel.percentage.intValue;
        endAngle = (percentage * 0.5) / 100.0 * M_PI * 2 + lableEndAngle;  //  保证Lable显示在中间
        lableEndAngle = percentage / 100.0 * M_PI * 2 + lableStartAngle;
        UILabel * lable = [[UILabel alloc] init];
        lable.text = [NSString stringWithFormat:@"%.f%%", percentage];
        [lable sizeToFit];
        lable.left = self.size.width * 0.5 - lable.width * 0.5;
        lable.top = self.height * 0.5 - self.radius - lable.height * 0.5 - self.lableMagin * 3 / 2;
        [self addSubview:lable];
        
        CGAffineTransform trans = GetCGAffineTransformRotateAroundPoint(centerX,centerY, x, y, endAngle);
        lable.transform = CGAffineTransformIdentity;
        lable.transform = trans;
        startAngle = endAngle;
        lableStartAngle = lableEndAngle;
    }
}

- (void)drawRect:(CGRect)rect
{
    if (self.modelArray.count == 0)
    {
        return;
    }
    switch (self.graphStyle)
    {
        case CustomPanCakeGraphStyleDefalue:
        {
            [self CustomPanCakeGraphStyleDefalueEithRect:rect];
        }
            break;
            
        default:
            break;
    }
}

- (void)CustomPanCakeGraphStyleDefalueEithRect:(CGRect)rect
{
    CGPoint originPoint = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radiusMax = (rect.size.width < rect.size.height) ? rect.size.width * 0.5: rect.size.height * 0.5;
    CGFloat startAngle = - M_PI * 0.5;
    CGFloat endAngle;
    CGFloat percentage;
    self.radius = (self.radius < radiusMax) ? self.radius : radiusMax - self.lineWidth;
    self.lineWidth = (self.lineWidth != 0) ? self.lineWidth : 1;
    
    for (int i = 0; i < self.modelArray.count; i++)
    {
        DJCustomPanCakeGraphModel *model = self.modelArray[i];
        percentage = (model.percentage.intValue == 0) ? model.percentage.floatValue :  model.percentage.integerValue / 100.0;
        endAngle = percentage * M_PI * 2 + startAngle;
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(context, originPoint.x, originPoint.y);
        CGContextAddArc(context, originPoint.x, originPoint.y, self.radius, startAngle, endAngle, 0);
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextSetStrokeColorWithColor(context, model.color.CGColor);
        CGContextSetFillColorWithColor(context, model.color.CGColor);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
        startAngle = endAngle;
    }
}

@end
