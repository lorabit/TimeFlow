//
//  TimeLineViewController.m
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import "TimeLineViewController.h"
#import "CategoryModel.h"

@interface TimeLineViewController (){
  
}

@end

@implementation TimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.viewControllerStyle = TFViewControllerStyleYellow;
  self.title = @"TimeFlow";
  [self configureUIAppearance];
  CategoryModel * model = [[CategoryModel alloc] init];
  [model save];
  NSLog(@"%@",((NSNumber*)model.primaryKeyValue).description);
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureUIAppearance{
  
}


@end
