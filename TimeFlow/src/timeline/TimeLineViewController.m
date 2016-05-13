//
//  TimeLineViewController.m
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import "TimeLineViewController.h"
#import "CategoryModel.h"
#import "TFEditorViewController.h"
#import "ResultViewController.h"

@interface TimeLineViewController (){
  
}

@end

@implementation TimeLineViewController

UITextField * textField;

- (void)viewDidLoad {
    [super viewDidLoad];
  self.viewControllerStyle = TFViewControllerStyleYellow;
  self.title = @"TimeFlow";
  [self configureUIAppearance];
 
    
    UIButton* btn = [[UIButton alloc] init];
    [btn setTitle:@"Search" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    
    
    textField = [[UITextField alloc] init];
    textField.backgroundColor = [UIColor whiteColor];
    
   
    
    [self.view addSubview:textField];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
    [self.view addGestureRecognizer:tapGesture];
    
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).with.offset(10);
        make.height.and.width.equalTo(btn);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(10);
        make.left.equalTo(self.view).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
        make.height.equalTo(@50);
    }];
}

-(void)tapView{
     [textField resignFirstResponder];
}

-(void)tap{
    ResultViewController* resultVC = [ResultViewController new];
    resultVC.keyword = textField.text;
    [self.navigationController pushViewController:resultVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureUIAppearance{
  
}


@end
