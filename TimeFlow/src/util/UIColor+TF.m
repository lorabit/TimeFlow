//
//  UIColor+TF.m
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import "UIColor+TF.h"

@implementation UIColor (TF)

+ (UIColor *)hexColorFloat:(NSString *)floatColorString {
  if (floatColorString.length < 6) {
    return nil;
  }
  
  NSRange scanRange;
  scanRange.length = 2;
  unsigned int _red,_green,_blue;
  
  // red
  scanRange.location = 0;
  [[NSScanner scannerWithString:[floatColorString substringWithRange:scanRange]] scanHexInt:&_red];
  
  // green
  scanRange.location = 2;
  [[NSScanner scannerWithString:[floatColorString substringWithRange:scanRange]] scanHexInt:&_green];
  
  // blue
  scanRange.location = 4;
  [[NSScanner scannerWithString:[floatColorString substringWithRange:scanRange]] scanHexInt:&_blue];
  
  return [UIColor colorWithRed:_red/255. green:_green/255. blue:_blue/255. alpha:1.];
}

+ (UIColor*) colorWithHex:(long)hexColor
{
  return [UIColor colorWithHex:hexColor alpha:1.];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
  float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
  float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
  float blue = ((float)(hexColor & 0xFF))/255.0;
  return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

@end
