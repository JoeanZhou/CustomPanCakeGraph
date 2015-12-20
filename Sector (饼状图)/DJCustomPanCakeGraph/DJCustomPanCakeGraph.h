//
//  DJCustomPanCakeGraph.h
//  Sector (饼状图)
//
//  Created by dajie on 15/12/19.
//  Copyright © 2015年 dajie. All rights reserved.
//

/**
 *  使用方法：
 *  1. 定义一个数组，里面装着颜色与百分比的字典(百分比可以是小数(0.5) 可以是整数(50))
 *  2. 设置基本的参数，如半径、线宽...
 *  3. 在DJCustomPanCakeGraphModel中将你字典中的字段与  需要模型中的字段相对应(必须一样)。
 *  4. 集成完成
 
 *  特别注意，非常依赖 DJCustomPanCakeGraph模型，不然会报错或者崩溃
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CustomPanCakeGraphStyle)
{
    CustomPanCakeGraphStyleDefalue
};

@interface DJCustomPanCakeGraph : UIView

/**
 *  数组字典，需要传进一个数组里面装着字典
 */
@property (nonatomic, strong, readwrite) NSArray *dataArray;
/**
 *  所需要画的半径，超出视图自动用视图的最小宽高计算
 */
@property (nonatomic, assign, readwrite) CGFloat radius;
/**
 *  边框线的宽度，默认为 1。
 */
@property (nonatomic, assign, readwrite) CGFloat lineWidth;
/**
 *  需要显示的百分比文字距离饼状图的间隙
 */
@property (nonatomic, assign, readwrite) NSInteger lableMagin;
/**
 *  是否显示百分比文字
 */
@property (nonatomic, assign, readwrite, getter=isShowTipLable) BOOL showTipLable;

/**
 *  百分比文字颜色(默认跟随扇形颜色)。
 */
@property (nonatomic, strong) UIColor *tipLableTextColor;
/**
 *  百分比颜色字体 (默认喂系统自带字号)
 */
@property (nonatomic, assign) CGFloat tipLableTextFont;

/**
 *  视图样式，默认为饼状图，待扩充
 */
@property (nonatomic, assign) CustomPanCakeGraphStyle graphStyle;

@end
