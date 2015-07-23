//
//  ViewController.m
//  GGZipImage
//
//  Created by __无邪_ on 15/7/23.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "ViewController.h"
#import "GGZipImage.h"
#import "GGCamera.h"
@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    ///对比视图1
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)/2)];
    [self.view addSubview:imageView1];
    [imageView1 setClipsToBounds:YES];
    [imageView1 setContentMode:UIViewContentModeScaleAspectFill];
    
    ///对比视图2
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) / 2, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)/2)];
    [self.view addSubview:imageView2];
    [imageView2 setClipsToBounds:YES];
    [imageView2 setContentMode:UIViewContentModeScaleAspectFill];
    
    
    
    
    ////新视图
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    [self.view addSubview:self.imageView];
    [self.imageView setClipsToBounds:YES];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCamera:)];
    [self.imageView setUserInteractionEnabled:YES];
    [self.imageView addGestureRecognizer:tapGesture];
    
    
    
    
    
    
    
    
    
    
    
    
    //    NSString *imageName = @"HYQ.jpg";
    //    NSString *imageName = @"girl.jpg";
    //    NSString *imageName = @"7.jpg";//287kb
    NSString *imageName = @"guide.png";//501kb
    //    NSString *imageName = @"lol.jpg";//1.3M
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *newImage = [[GGZipImage sharedImage] zipImageWithImage:image];
    
    [imageView1 setImage:image];   //原图
    [imageView2 setImage:newImage];//结果图

    
    
    
    
    
    
    
    
    
//    ///图片压缩
//    
//    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"girl" ofType:@"jpg"];
//    NSData *data = [NSData dataWithContentsOfFile:imagePath];
//    NSLog(@"原始大小：%ld kb",data.length / 1024);
//    
//    ////1.固定压缩比例，增加压缩次数
//    NSLog(@"固定压缩比例，增加压缩次数");
//    float kCompressionQuality = 0.15;
//    UIImage *jpgImage = [UIImage imageNamed:@"girl.jpg"];
//    NSData *photo = UIImageJPEGRepresentation(jpgImage, kCompressionQuality);
//    NSLog(@"%ld kb",photo.length / 1024);
//    [imageView1 setImage:jpgImage];
//    
//    for (int i = 0; i < 5; i++) {
//        
//        UIImage *imagenew = [UIImage imageWithData:photo];
//        photo = UIImageJPEGRepresentation(imagenew, kCompressionQuality);
//        NSLog(@"第 %d 次  %4ld kb,压缩比：%f",i,photo.length / 1024,kCompressionQuality);
////        
////        if (i == 4) {
////            [imageView2 setImage:imagenew];
////        }
//    }
//    
//    ////2.改变压缩系数
//    NSLog(@"不断改变压缩系数:");
//    NSMutableArray *alterableQualityArr = [[NSMutableArray alloc] init];
//    
//    // 生成压缩比例系数(6 * 9 = 54个)
//    for (int i = 1; i < 7; i ++) {
//        for (int j = 9; j > 0; j --) {
//            NSNumber *quality = @(j / pow(10.0, i));
//            [alterableQualityArr addObject:quality];
//            ///NSLog(@"%d  %20.0f  %@",j ,pow(10.0, i), quality);
//        }
//    }
//    
//    
//    for (int i = 0; i < alterableQualityArr.count; i++) {
//        CGFloat alterableQuality = [alterableQualityArr[i] floatValue];
//        UIImage *imagenew = [UIImage imageWithData:data];
//        photo = UIImageJPEGRepresentation(imagenew, alterableQuality);
//        NSLog(@"第 %2d 次  %4ld kb,压缩比：%f",i,photo.length / 1024,alterableQuality);
//        
//        if (photo.length / 1024 > 200) {
//            //继续压
//        }else{
//            //stop
//            [imageView2 setImage:imagenew];
//            break;
//        }
//    }

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Action

- (void)showCamera:(id)sender{
    [[GGCamera sharedInstance] showCameraResult:^(UIImage *image) {
        UIImage *newImage = [[GGZipImage sharedImage] zipImageWithImage:image];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageView setImage:newImage];
        });
    }];
}









@end
