//
//  TFViewController.h
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
  TFViewControllerStyleYellow
} TFViewControllerStyle;


@interface TFViewController : UIViewController

@property(nonatomic,assign) TFViewControllerStyle viewControllerStyle;
@property(nonatomic,copy) NSString* pageTitle;

-(void)configureUIAppearance;


@end
