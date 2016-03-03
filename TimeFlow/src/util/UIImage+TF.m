//
//  UIImage+TF.m
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import "UIImage+TF.h"

@implementation UIImage (TF)



CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
  // calculate the size of the rotated view's containing box for our drawing space
  UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
  CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
  rotatedViewBox.transform = t;
  CGSize rotatedSize = rotatedViewBox.frame.size;
  
  // Create the bitmap context
  UIGraphicsBeginImageContext(rotatedSize);
  CGContextRef bitmap = UIGraphicsGetCurrentContext();
  
  // Move the origin to the middle of the image so we will rotate and scale around the center.
  CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
  
  //   // Rotate the image context
  CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
  
  // Now, draw the rotated/scaled image into the context
  CGContextScaleCTM(bitmap, 1.0, -1.0);
  CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
  
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
  
}
+ (UIImage *)screenShoot:(UIView *)view {
  
  UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.);
  [view.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size {
  
  UIImage *image = nil;
  UIGraphicsBeginImageContextWithOptions(size, NO, 0.);
  [color setFill];
  UIRectFill(CGRectMake(0, 0, size.width, size.height));
  image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

+ (UIImage *)opaqueImageWithRenderColor:(UIColor *)color renderSize:(CGSize)size {
  UIImage *image = nil;
  UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
  [color setFill];
  UIRectFill(CGRectMake(0, 0, size.width, size.height));
  image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

- (UIImage *)scaleFitToSize:(CGSize)size {
  
  CGFloat scaleRate = MIN(size.width / self.size.width, size.height / self.size.height);
  return [self scaleImageToSize:size rate:scaleRate];
}

- (UIImage *)scaleFillToSize:(CGSize)size {
  
  CGFloat scaleRate = MAX(size.width / self.size.width, size.height / self.size.height);
  return [self scaleImageToSize:size rate:scaleRate];
}

+ (UIImage*)scaleDown:(UIImage*)image withSize:(CGSize)newSize {
  
  UIGraphicsBeginImageContextWithOptions(newSize, YES, 0.0);
  [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
  UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return scaledImage;
}

- (UIImage *)scaleImageToSize:(CGSize)size rate:(CGFloat)scaleRate {
  
  UIImage *image = nil;
  CGSize renderSize = CGSizeMake(self.size.width * scaleRate, self.size.height * scaleRate);
  CGFloat startX = size.width * 0.5 - renderSize.width * 0.5;
  CGFloat startY = size.height * 0.5 - renderSize.height * 0.5;
  
  CGImageAlphaInfo info = CGImageGetAlphaInfo(self.CGImage);
  BOOL opaque = (info == kCGImageAlphaNone) || (info == kCGImageAlphaNoneSkipFirst) || (info == kCGImageAlphaNoneSkipLast);
  
  UIGraphicsBeginImageContextWithOptions(size, opaque, 0.);
  UIColor *backgroundColor = opaque ? [UIColor whiteColor] : [UIColor clearColor];
  [backgroundColor setFill];
  UIRectFillUsingBlendMode(CGRectMake(0, 0, size.width, size.height), kCGBlendModeNormal);
  
  [self drawInRect:CGRectMake(startX, startY, renderSize.width, renderSize.height)];
  image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}

+ (UIImage *)imageWithCornerRadius:(float)radius fillColor:(UIColor *)fillColor StrokeColor:(UIColor *)strokeColor {
  CGSize renderSize = CGSizeMake(20, 20);
  UIGraphicsBeginImageContextWithOptions(renderSize, NO, 0.);
  CGContextRef drawCtx = UIGraphicsGetCurrentContext();
  CGPathRef borderPath = CGPathCreateWithRoundedRect((CGRect){CGPointZero,renderSize}, radius, radius, NULL);
  CGContextAddPath(drawCtx, borderPath);
  if (strokeColor) {
    [strokeColor setStroke];
    CGContextDrawPath(drawCtx, kCGPathStroke);
  }
  if (fillColor) {
    [fillColor setFill];
    CGContextDrawPath(drawCtx, kCGPathFill);
  }
  UIImage *resImage = [UIGraphicsGetImageFromCurrentImageContext() resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius)];
  UIGraphicsEndImageContext();
  CGPathRelease(borderPath);
  
  return resImage;
}

+ (UIImage *)imageWithSize:(CGSize)size lineWidth:(CGFloat)lineWidth cornerRadius:(CGFloat)radius fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor {
  
  CGRect circleRect = CGRectMake(lineWidth , lineWidth, size.width-lineWidth*2, size.height-lineWidth*2);
  UIGraphicsBeginImageContextWithOptions(size, NO, 0.);
  CGContextRef drawCtx = UIGraphicsGetCurrentContext();
  CGPathRef renderPath = CGPathCreateWithRoundedRect(circleRect, radius, radius, NULL);
  CGContextAddPath(drawCtx, renderPath);
  
  if (strokeColor && fillColor) {
    [fillColor setFill];
    [strokeColor setStroke];
    
    CGContextDrawPath(drawCtx, kCGPathFillStroke);
  } else {
    if (fillColor) {
      [fillColor setFill];
      CGContextDrawPath(drawCtx, kCGPathFill);
    } else if (strokeColor) {
      [strokeColor setStroke];
      CGContextDrawPath(drawCtx, kCGPathStroke);
    }
  }
  
  UIImage *resImage = [UIGraphicsGetImageFromCurrentImageContext() resizableImageWithCapInsets:UIEdgeInsetsMake(lineWidth+radius, lineWidth+radius, lineWidth+radius, lineWidth+radius)];
  UIGraphicsEndImageContext();
  CGPathRelease(renderPath);
  
  return resImage;
}

-(NSData*)jpegDataWithQuality:(float )quality Size:(int) size{
  NSData* data;
  if(size == 0){
    data = UIImageJPEGRepresentation(self, quality);
    return data;
  }else{
    CGSize  newSize;
    if(self.size.height>self.size.width){
      newSize = CGSizeMake(size, size/self.size.width*self.size.height);
    }else{
      newSize = CGSizeMake(size/self.size.height*self.size.width, size);
    }
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    data = UIImageJPEGRepresentation(newImage, quality);
    return data;
  }
}


@end
