//
//  UIColor+TF.h
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (TF)

+ (UIColor *)hexColorFloat:(NSString *)floatColorString;

+ (UIColor*) colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;
@end
