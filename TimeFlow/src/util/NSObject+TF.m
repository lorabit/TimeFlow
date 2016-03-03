//
//  NSObject+TF.m
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import "NSObject+TF.h"

@implementation NSObject (TF)


+(NSArray*)propertyList{
  NSMutableArray* result = [NSMutableArray new];
  unsigned int numberOfProperties;
  objc_property_t * properties = class_copyPropertyList(self.class, &numberOfProperties);
  for(int i=0;i<numberOfProperties;i++){
    objc_property_t property = properties[i];
    NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
    [result addObject:propertyName];
  }
  free(properties);
  return [NSArray arrayWithArray:result];
}

@end
