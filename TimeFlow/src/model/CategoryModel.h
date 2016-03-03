//
//  CategoryModel.h
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import "TFModel.h"

//create table if not exists category(modelid INTEGER PRIMARY KEY AUTOINCREMENT, title text, color bigint);

@interface CategoryModel : TFModel

@property(nonatomic,strong) NSNumber* modelid;
@property(nonatomic,copy) NSString* title;
@property(nonatomic,strong) NSNumber* color;

@end
