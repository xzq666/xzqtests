//
//  ClickViewController.m
//  xzqtest
//
//  Created by 许卓权 on 15/10/29.
//  Copyright © 2015年 CCT. All rights reserved.
//

#import "ClickViewController.h"
#import "PHPulsingHaloLayer.h"

@implementation ClickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"戳一戳测试";
    
    UILabel *aLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    aLabel.numberOfLines = 0;
    aLabel.textAlignment = NSTextAlignmentCenter;
    aLabel.text = @"点我\n或者拖动";
    [self.view addSubview:aLabel];
    
    UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [clearButton setTitle:@"clearn" forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [clearButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [clearButton addTarget:self action:@selector(clearn) forControlEvents:UIControlEventTouchUpInside];
    clearButton.center = CGPointMake(self.view.bounds.size.width - 50, 40);
    [self.view addSubview:clearButton];
}

- (void)clearn {
    NSArray *sublayers = [self.view.layer.sublayers mutableCopy];
    for(PHPulsingHaloLayer *obj in sublayers) {
        if([obj isKindOfClass:[PHPulsingHaloLayer class]] && obj.superlayer == self.view.layer)  {
            [obj closeAnimation];
            [obj removeFromSuperlayer];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint tPoint = [touch locationInView:self.view];
    [self addLaberWithPoint:tPoint count:0];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint tPoint = [touch locationInView:self.view];
    [self addLaberWithPoint:tPoint count:1];
}

- (void)addLaberWithPoint:(CGPoint)tPoint count:(NSInteger)count {
    PHPulsingHaloLayer *layer = [[PHPulsingHaloLayer alloc] init];
    layer.animationDuration = 0.5;
    layer.radius = 30;
    layer.animationTimes = count; //为1时可停止
    layer.position = tPoint;
    [self.view.layer addSublayer:layer];
    [layer beginAnimationAfterDelay:0];
}

@end