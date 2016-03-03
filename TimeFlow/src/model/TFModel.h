//
//  TFModel.h
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
  TFDBActionSelect,
  TFDBActionSave
} TFDBAction;

@interface TFModel : NSObject

+(TFModel*)model;
+(NSString*)tableName;
+(NSString*)primaryKey;
-(id)primaryKeyValue;
+(id)primaryKeyDefaultValue;
-(BOOL)isNewRecord;
+(NSArray*)columnsForAction:(TFDBAction)action;
-(BOOL)save;
-(instancetype)initWithPkValue:(id)value;

@end
