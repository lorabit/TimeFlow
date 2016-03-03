//
//  TFModel.m
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import "TFModel.h"

@implementation TFModel

+(TFModel *)model{
  return [[[self class] alloc] init];
}

+(NSString *)tableName{
  return @"";
}

+(NSString *)primaryKey{
  return @"modelid";
}

-(id)primaryKeyValue{
  return [self valueForKey:self.class.primaryKey];
}

+(id)primaryKeyDefaultValue{
  return @0;
}

-(BOOL)isNewRecord{
  return [self.primaryKeyValue isEqual:[self class].primaryKeyDefaultValue];
}

+(NSString*)paramLabelStringWithCount:(unsigned long) count{
  NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:count];
  for(int i = 0;i<count;i++)
    [array addObject:@"?"];
  return [array componentsJoinedByString:@","];
}

+(NSString*)setStatementForColumns:(NSArray*)columns{
  NSMutableArray* array = [[NSMutableArray alloc] init];
  for(NSString * column in columns){
    [array addObject:[NSString stringWithFormat:@"%@ = ?",column]];
  }
  return [array componentsJoinedByString:@","];
}


-(BOOL)save{
  NSArray * saveNodeColumns = [self.class columnsForAction:TFDBActionSave];
  NSString * sql;
  int insert = 0;
  if(self.isNewRecord){
    insert = 1;
    sql = [NSString stringWithFormat:@"insert into %@(%@) values(%@);",self.class.tableName,[saveNodeColumns componentsJoinedByString:@","],[self.class paramLabelStringWithCount:[saveNodeColumns count]]];
  }else{
    sql = [NSString stringWithFormat:@"update %@ set %@ where %@ = %@;",self.class.tableName,[self.class setStatementForColumns:saveNodeColumns],self.class.primaryKey,self.primaryKeyValue];
  }
  NSMutableArray* paramArray = [[NSMutableArray alloc] init];
  for (NSString* column in saveNodeColumns) {
    id value = [self valueForKey:column];
    if(value == nil){
      NSLog(@"====== WMCache Warning ======\nMissing column %@ saving schema %@.",column,self.class.tableName);
      id defaultValues = [[[self class] alloc] init];
      value = [defaultValues valueForKey:column];
    }
    [paramArray addObject:value];
  }
  [[TFDataBase db].queue inDatabase:^(FMDatabase *db) {
    [db executeUpdate:sql withArgumentsInArray:paramArray];
    if(insert == 1)
      [self setValue:[NSNumber numberWithLongLong:[db lastInsertRowId]] forKey:self.class.primaryKey];
  }];
  return YES;
}


+(NSArray*)columnsForAction:(TFDBAction)action{
  NSMutableArray* result = [NSMutableArray arrayWithArray:[self propertyList]];
  NSString* keyToRemove;
  for(NSString* key in result)
    if([key isEqualToString:[self primaryKey]]){
      keyToRemove = key;
      break;
    }
  [result removeObject:keyToRemove];
  if(action == TFDBActionSelect)
    return [result arrayByAddingObject:[self primaryKey]];
  return [NSArray arrayWithArray:result];
}


-(instancetype)initFromResultSet:(FMResultSet*) resultSet{
  self = [self init];
  if(self!=nil){
    NSArray * columns = [self.class columnsForAction:TFDBActionSelect];
    for (NSString* column in columns) {
      [self setValue:[resultSet objectForColumnName:column] forKey:column];
    }
  }
  return self;
}

-(instancetype)initWithPkValue:(id)value{
  self = [self init];
  if(self!=nil){
    NSString* sql = [NSString stringWithFormat:@"select * from %@ where %@ = ?;",self.class.tableName,self.class.primaryKey];
    [[TFDataBase db].queue inDatabase:^(FMDatabase *db) {
      FMResultSet* resultSet = [db executeQuery:sql,self.primaryKeyValue];
      if (resultSet) {
        [self initFromResultSet:resultSet];
      }
      [resultSet close];
    }];
  }
  return self;
}




@end
