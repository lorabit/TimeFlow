//
//  ImageCell.h
//  TimeFlow
//
//  Created by lorabit on 5/13/16.
//
//

#import <UIKit/UIKit.h>

@protocol ImageCellDelegate <NSObject>

-(void)clickBtn;

@end

typedef void(^DefaultBlock)();

@interface ImageCell : UITableViewCell

@property(nonatomic,strong) NSDictionary* data;
@property(nonatomic,weak) id<ImageCellDelegate> controller;
@property(nonatomic,copy) DefaultBlock block;

@end
