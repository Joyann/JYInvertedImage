//
//  ViewController.m
//  JYInvertedImage
//
//  Created by joyann on 15/10/25.
//  Copyright © 2015年 Joyann. All rights reserved.
//

#import "ViewController.h"
#import "JYView.h"

/*
 两种方式实现图片倒影：
 1. 在addRepLayer方法中，在self.view.layer之上添加一个repLayer以完成操作.
 2. 自定义UIView，修改它的layerClass，将self.view.layer变成一个repLayer以完成操作.
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self addRepLayer];
    [self useRepLayer];
}

#pragma mark - 第二种方法

- (void)loadView
{
    JYView *view = [[JYView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor lightGrayColor];
    self.view = view;
}

- (void)useRepLayer
{
    CAReplicatorLayer *repLayer = (CAReplicatorLayer *)self.view.layer;
    repLayer.instanceCount = 2;
    repLayer.instanceTransform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    // 设置倒影
    repLayer.instanceRedOffset -= 0.1;
    repLayer.instanceGreenOffset -= 0.1;
    repLayer.instanceBlueOffset -= 0.1;
    repLayer.instanceAlphaOffset -= 0.1;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.image = [UIImage imageNamed:@"卡哇伊"];
    imageView.center = CGPointMake(repLayer.bounds.size.width * 0.5, repLayer.bounds.size.height * 0.5  - imageView.bounds.size.height * 0.5);
    [repLayer addSublayer:imageView.layer];

}

#pragma mark - 第一种方法

- (void)addRepLayer
{
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // 增加复制层
    CAReplicatorLayer *repLayer = [CAReplicatorLayer layer];
    repLayer.frame = self.view.bounds;
    repLayer.instanceCount = 2;
    repLayer.instanceTransform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    // 设置倒影
    repLayer.instanceRedOffset -= 0.1;
    repLayer.instanceGreenOffset -= 0.1;
    repLayer.instanceBlueOffset -= 0.1;
    repLayer.instanceAlphaOffset -= 0.1;
    [self.view.layer addSublayer:repLayer];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    imageView.image = [UIImage imageNamed:@"卡哇伊"];
    imageView.center = CGPointMake(repLayer.bounds.size.width * 0.5, repLayer.bounds.size.height * 0.5  - imageView.bounds.size.height * 0.5);
    [repLayer addSublayer:imageView.layer];
}

@end
