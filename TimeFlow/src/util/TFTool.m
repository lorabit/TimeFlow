//
//  TFTool.m
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import "TFTool.h"


void swizzled_Method(Class class,SEL originalSelector,SEL swizzledSelector) {
  Method originalMethod = class_getInstanceMethod(class, originalSelector);
  Method swizzeldMethod = class_getInstanceMethod(class, swizzledSelector);
  
  BOOL didSwizzle = class_addMethod(class, originalSelector, method_getImplementation(swizzeldMethod), method_getTypeEncoding(swizzeldMethod));
  
  if (didSwizzle) {
    class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
  } else {
    method_exchangeImplementations(originalMethod, swizzeldMethod);
  }
}



@implementation TFTool

@end
