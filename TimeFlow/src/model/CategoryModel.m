//
//  CategoryModel.m
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import "CategoryModel.h"

@implementation CategoryModel

+(NSString *)tableName{
  return @"category";
}

-(instancetype)init{
  self = [super init];
  if(self){
    self.modelid = @0;
    self.title = @"";
    self.color = @0;
  }
  return self;
}

@end
