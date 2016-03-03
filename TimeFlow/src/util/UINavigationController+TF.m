//
//  UINavigationController+TF.m
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import "UINavigationController+TF.h"

@implementation UINavigationController (TF)

-(UIStatusBarStyle)preferredStatusBarStyle{
  if(self.topViewController)
    return self.topViewController.preferredStatusBarStyle;
  return UIStatusBarStyleDefault;
}

@end
