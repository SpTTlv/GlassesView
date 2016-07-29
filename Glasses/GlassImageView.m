//
//  GlassImageView.m
//  Glasses
//
//  Created by lv on 16/7/29.
//  Copyright © 2016年 lv. All rights reserved.
//

#import "GlassImageView.h"


#define BigGW 70
@interface GlassImageView()
/**
 *  放大镜
 */
@property (nonatomic, strong)UIImageView * bigGlassesIv;


@end

@implementation GlassImageView
- (UIImageView *)bigGlassesIv
{
    if (_bigGlassesIv == nil) {
        _bigGlassesIv = [[UIImageView alloc] init];
        _bigGlassesIv.layer.cornerRadius = BigGW * 0.5;
        _bigGlassesIv.layer.masksToBounds = YES;

    }
    return _bigGlassesIv;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    UITouch * touch = [touches anyObject];
    //在ImageView中的起始坐标
    CGPoint startP = [touch locationInView:self];

    self.bigGlassesIv.frame = CGRectMake(0, 0, BigGW, BigGW);
    _bigGlassesIv.center = startP;

    [self addSubview:_bigGlassesIv];
    _bigGlassesIv.image = [self getGlassImageInPoint:startP];

}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint currentP = [touch locationInView:self];
    
    self.bigGlassesIv.frame = CGRectMake(0, 0, BigGW, BigGW);
    self.bigGlassesIv.center = currentP;
    [self addSubview:_bigGlassesIv];
    self.bigGlassesIv.image = [self getGlassImageInPoint:currentP];
    //如果触摸点不在图片上
    if (!CGRectContainsPoint(self.bounds, currentP)) {
        [_bigGlassesIv removeFromSuperview];
        _bigGlassesIv = nil;
    }
    
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.bigGlassesIv) {
        [_bigGlassesIv removeFromSuperview];
        _bigGlassesIv = nil;
    }
}
//获取放大的图片
- (UIImage *)getGlassImageInPoint:(CGPoint)point
{

    UIImage * startImage = [UIImage imageNamed:self.imageName];
    //获取在实际图片中应该显示的坐标
    CGFloat x = point.x * startImage.size.width/self.bounds.size.width -35;
    CGFloat y = point.y * startImage.size.height/self.bounds.size.height -35;
    
    CGRect rect = CGRectMake(x, y, BigGW, BigGW);
    //获取原始图片的像素位图
    CGImageRef imageRef = startImage.CGImage;
    //获取rect中的位图
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, rect);
    
    CGSize size = CGSizeMake(BigGW, BigGW);
    
    //开启size大小的image上下文
    UIGraphicsBeginImageContext(size);
    //获取当前上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextDrawImage(contextRef, rect, subImageRef);
    UIImage * newImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    return newImage;

}


@end
