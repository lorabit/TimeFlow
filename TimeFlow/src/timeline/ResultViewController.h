//
//  ResultViewController.h
//  TimeFlow
//
//  Created by lorabit on 5/12/16.
//
//

#import <UIKit/UIKit.h>

#import "ImageCell.h"

@interface ResultViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ImageCellDelegate>

@property(nonatomic,copy) NSString* keyword;

@end
