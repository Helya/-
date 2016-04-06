//
//  StepImageViewController.m
//  StepImage
//
//  Created by 余敏侠 on 16/4/6.
//  Copyright © 2016年 secrui Co.,Ltd. All rights reserved.
//

#import "StepImageViewController.h"
#import <ImageIO/ImageIO.h>
@interface StepImageViewController ()<NSURLConnectionDataDelegate>
@property(nonatomic,strong) NSURLRequest * request;
@property(nonatomic,strong) NSURLConnection * conn;
@property(nonatomic,assign) CGImageSourceRef  imcrementallyImgSource;
@property(nonatomic,strong) NSMutableData * recieveData;
@property(nonatomic,assign) bool  isLoadFinished;
@property(nonatomic,assign) long long expectedLeght;
@end

@implementation StepImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)startRequest
{
    self.request =[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.URLName]];
    _conn    = [[NSURLConnection alloc] initWithRequest:_request delegate:self];

    _imcrementallyImgSource = CGImageSourceCreateIncremental(NULL);

    _recieveData = [[NSMutableData alloc] init];
    _isLoadFinished = false;
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"response %@",response);
    NSString *mimeType = response.MIMEType;
    NSLog(@"MIME TYPE %@", mimeType);
    _expectedLeght = response.expectedContentLength;
    NSLog(@"expected Length: %lld", _expectedLeght);

    NSArray *arr = [mimeType componentsSeparatedByString:@"/"];
    if (arr.count < 1 || ![[arr objectAtIndex:0] isEqual:@"image"]) {
        NSLog(@"not a image url");
        [connection cancel];
        _conn = nil;
    }

}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"finished loading....");
    if (!_isLoadFinished) {
        CGImageSourceUpdateData(_imcrementallyImgSource, (CFDataRef)_recieveData, _isLoadFinished);
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(_imcrementallyImgSource, 0, NULL);
        self.imageView.image = [UIImage imageWithCGImage:imageRef ];
        CGImageRelease(imageRef);

    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_recieveData appendData:data];
    _isLoadFinished = false;
    if (_expectedLeght == _recieveData.length) {
        _isLoadFinished = true;
    }
    NSLog(@"recieve data...");
    CGImageSourceUpdateData(_imcrementallyImgSource, (CFDataRef)_recieveData, _isLoadFinished);
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(_imcrementallyImgSource, 0, NULL);
    self.imageView.image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
