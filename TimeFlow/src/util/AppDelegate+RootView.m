//
//  AppDelegate+RootView.m
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import "AppDelegate+RootView.h"
#import "TimeLineViewController.h"

@implementation AppDelegate (RootView)

+(void)load{
  swizzled_Method([self class], @selector(application:didFinishLaunchingWithOptions:), @selector(rootView_application:didFinishLaunchingWithOptions:));
}

- (BOOL)rootView_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  [self rootView_application:application didFinishLaunchingWithOptions:launchOptions];
  
  self.window = [[UIWindow alloc] initWithFrame:MainScreenBounds];
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  

  TimeLineViewController* timelineViewController = [[TimeLineViewController alloc] init];
  UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:timelineViewController];
  self.window.rootViewController = nav;
  return YES;
}

@end
