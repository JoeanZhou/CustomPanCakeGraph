//
//  ViewController.m
//  Sector (饼状图)
//
//  Created by dajie on 15/12/19.
//  Copyright © 2015年 dajie. All rights reserved.
//

#import "ViewController.h"
#import "DJCustomPanCakeGraph.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet DJCustomPanCakeGraph *pancakeGraph;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

   
    self.pancakeGraph.dataArray = @[@{
                                        @"percentage" : @(45),
                                        @"color" : RandomColor
                                        
                                        },
                                    @{
                                        @"percentage" : @(15),
                                        @"color" : RandomColor
                                        },
                                    @{
                                        @"percentage" : @(8),
                                        @"color" : RandomColor
                                        },
                                    @{
                                        @"percentage" : @(4),
                                        @"color" : RandomColor
                                        },
                                    @{
                                        @"percentage" : @(20),
                                        @"color" : RandomColor
                                        },
                                    @{
                                        @"percentage" : @(8),
                                        @"color" : RandomColor
                                        }

                                    ];
    
    self.pancakeGraph.radius = 80;
    self.pancakeGraph.lineWidth = 0.5;
    self.pancakeGraph.lableMagin = 15;
    self.pancakeGraph.showTipLable = YES;
    self.pancakeGraph.tipLableTextFont = 12.0;
}

@end
