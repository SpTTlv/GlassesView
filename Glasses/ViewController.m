//
//  ViewController.m
//  Glasses
//
//  Created by lv on 16/7/29.
//  Copyright © 2016年 lv. All rights reserved.
//

#import "ViewController.h"
#import "GlassImageView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet GlassImageView *glassImageV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage * newImage = [self scaleFromImage:[UIImage imageNamed:@"backImage"] toSize:CGSizeMake(300, 300)];
    self.glassImageV.image = newImage;
    self.glassImageV.imageName = @"backImage";
}
//缩放图片
- (UIImage *)scaleFromImage:(UIImage *)image toSize:(CGSize)size
{
    //创建一个size大小的上下文
    UIGraphicsBeginImageContext(size);
    //将图片绘制上去
    [image drawInRect:CGRectMake(0, 0, size.width, size.width)];
    //获得绘制好的新的图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}
@end
