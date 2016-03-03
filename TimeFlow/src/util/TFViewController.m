//
//  TFViewController.m
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import "TFViewController.h"

@implementation TFViewController

-(void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  switch (_viewControllerStyle) {
    case TFViewControllerStyleYellow:
      self.view.backgroundColor = [UIColor colorWithHex:0x252429];
      [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithRenderColor:[UIColor colorWithHex:0xf1ae21] renderSize:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
      self.navigationController.navigationBar.translucent = NO;
      [self.navigationController.navigationBar setTitleTextAttributes:
       @{NSFontAttributeName:[UIFont systemFontOfSize:18],
         NSForegroundColorAttributeName:[UIColor hexColorFloat:@"FFFFFF"]}];
      break;
      
    default:
      break;
  }
}

-(UIStatusBarStyle)preferredStatusBarStyle{
  return UIStatusBarStyleLightContent;
}

-(void)configureUIAppearance{

}

@end
