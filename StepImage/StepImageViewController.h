//
//  StepImageViewController.h
//  StepImage
//
//  Created by 余敏侠 on 16/4/6.
//  Copyright © 2016年 secrui Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StepImageViewController : UIViewController
@property(nonatomic,strong) NSString * URLName;
@property(nonatomic,strong) UIImageView * imageView;
-(void)startRequest;
@end
