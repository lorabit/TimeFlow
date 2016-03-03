//
//  UIImage+TF.h
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (TF)


- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

+ (UIImage *)screenShoot:(UIView *)view;

- (UIImage *)scaleFitToSize:(CGSize)size;

- (UIImage *)scaleFillToSize:(CGSize)size;

+ (UIImage*)scaleDown:(UIImage*)image withSize:(CGSize)newSize;

+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size;

+ (UIImage *)opaqueImageWithRenderColor:(UIColor *)color renderSize:(CGSize)size;

+ (UIImage *)imageWithCornerRadius:(float)radius fillColor:(UIColor *)fillColor StrokeColor:(UIColor *)strokeColor;

+ (UIImage *)imageWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)radius fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor;
-(NSData*)jpegDataWithQuality:(float )quality Size:(int) size;


@end
