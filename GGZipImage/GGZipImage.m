//
//  GGZipImage.m
//  GGZipImage
//
//  Created by __无邪_ on 15/7/23.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "GGZipImage.h"
#import "GGCamera.h"

const NSInteger kBytePerKB = 1024;  //每KB占多少byte
const NSInteger kMaxResultImageBulk = 200;//压缩后最大图片容量200kb


@interface GGZipImage ()
@property (nonatomic, strong)NSMutableArray *alterableQualityArr;
@end

@implementation GGZipImage


+ (GGZipImage *)sharedImage{
    static dispatch_once_t onceToken;
    static GGZipImage *zipImage;
    dispatch_once(&onceToken, ^{
        zipImage = [[GGZipImage alloc] init];
    });
    return zipImage;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        self.alterableQualityArr = [[NSMutableArray alloc] init];
        
        // 生成压缩比例系数(6 * 9 = 54个)
        for (int i = 1; i < 7; i ++) {
            for (int j = 9; j > 0; j --) {
                NSNumber *quality = @(j / pow(10.0, i));
                [self.alterableQualityArr addObject:quality];
                ///NSLog(@"%d  %20.0f  %@",j ,pow(10.0, i), quality);
            }
        }
        
    }
    return self;
}

#pragma mark - Fuck

- (UIImage *)zipImageWithImage:(UIImage *)originalImagle{
    ///图片压缩

    NSData *imageData = UIImageJPEGRepresentation(originalImagle, 1);
    
    NSInteger lastLength = imageData.length / kBytePerKB;
    NSLog(@"原始大小：%ld kb",lastLength);
    
    
    // 如果原始大小小于最大上限 kMaxResultImageBulk，直接返回
    
    if (lastLength < kMaxResultImageBulk) {return originalImagle;}
    
    
    ////2.改变压缩系数
    NSLog(@"不断改变压缩系数:");
    
    BOOL isEqual = NO;
    
    for (int i = 0; i < self.alterableQualityArr.count; i++) {
        CGFloat alterableQuality = [self.alterableQualityArr[i] floatValue];
        
        /** 从结果来看，循环压缩没有直接对原数据压缩效率高 */
        
        ///1,循环压缩
        //UIImage *imagenew = [UIImage imageWithData:imageData];
        //imageData = UIImageJPEGRepresentation(imagenew, alterableQuality);
        
        ///2,原数据压缩
        imageData = UIImageJPEGRepresentation(originalImagle, alterableQuality);
        
        NSInteger newLength = imageData.length / kBytePerKB;
        
        NSLog(@"第 %2d 次  %4ld kb,压缩比：%f",i + 1,newLength,alterableQuality);
        
        //计算是否满足继续压缩的条件
        if (lastLength == newLength) {//压缩到尽头了，stop
            if (isEqual) {
                break;//连续三次压缩后大小相同
            }else{
                isEqual = YES;
            }
        }
        
        lastLength = newLength;
        
        if (imageData.length / kBytePerKB > kMaxResultImageBulk) {//大于最大上限时继续压
        }else{//stop
            break;
        }
    }
    
    NSLog(@"压缩结束后大小：%ld kb",imageData.length / kBytePerKB);
    
    NSString *dateString = [[NSDate date] description];
    [[GGCamera sharedInstance] saveToSanbox:imageData withName:dateString];
    
    
    return [UIImage imageWithData:imageData];
    

}




@end
