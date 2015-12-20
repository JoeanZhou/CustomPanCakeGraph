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
                                        @"percentage" : @(10),
                                        @"color" : RandomColor
                                        
                                        },
                                    @{
                                        @"percentage" : @(23),
                                        @"color" : RandomColor
                                        },
                                    @{
                                        @"percentage" : @(15),
                                        @"color" : RandomColor
                                        },
                                    @{
                                        @"percentage" : @(18),
                                        @"color" : RandomColor
                                        },
                                    @{
                                        @"percentage" : @(12),
                                        @"color" : RandomColor
                                        },
                                    @{
                                        @"percentage" : @(12),
                                        @"color" : RandomColor
                                        },
                                    @{
                                        @"percentage" : @(5),
                                        @"color" : RandomColor
                                        },

                                    @{
                                        @"percentage" : @(5),
                                        @"color" : RandomColor
                                        }

                                    ];
    
    self.pancakeGraph.radius = 100;
    self.pancakeGraph.lineWidth = 0.5;
    self.pancakeGraph.lableMagin = 10;
    self.pancakeGraph.showTipLable = YES;
}

@end
