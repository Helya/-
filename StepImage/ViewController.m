//
//  ViewController.m
//  StepImage
//
//  Created by 余敏侠 on 16/4/6.
//  Copyright © 2016年 secrui Co.,Ltd. All rights reserved.
//

#import "ViewController.h"
#import <ImageIO/ImageIO.h>
#import <CoreFoundation/CoreFoundation.h>
#import "StepImageViewController.h"
@interface ViewController ()<NSURLConnectionDataDelegate>
@property(nonatomic,strong) UIImageView  * imageveiw;
@property(nonatomic,strong) NSURLRequest * request;
@property(nonatomic,strong) NSURLConnection * conn;
@property(nonatomic,assign) CGImageSourceRef  imcrementallyImgSource;
@property(nonatomic,strong) NSMutableData * recieveData;
@property(nonatomic,assign) bool  isLoadFinished;
@property(nonatomic,assign) long long expectedLeght;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 200, 100)];
    StepImageViewController *step = [[StepImageViewController alloc]init];
    step.URLName = @"http://f.hiphotos.baidu.com/zhidao/pic/item/728da9773912b31bf57838898218367adab4e17e.jpg";
    step.imageView = imageView;
    [step startRequest];
    [self.view addSubview:imageView];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
