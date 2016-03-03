//
//  TFDataBase.m
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import "TFDataBase.h"

@implementation TFDataBase

+(TFDataBase *)db{
  static TFDataBase* cache = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    cache = [[TFDataBase alloc] init];
  });
  return cache;
}

-(instancetype)init{
  self = [super init];
  if(self){
    [self connect];
    [self buildSchema];
  }
  return self;
}

-(void)connect{
  _queue = [FMDatabaseQueue databaseQueueWithPath:[DOCUMENTPATH stringByAppendingPathComponent:@"tfdb.sqlite3"]];
}

-(void)buildSchema{
  [_queue inDatabase:^(FMDatabase *db) {
    [db executeStatements:@"create table if not exists task(modelid INTEGER PRIMARY KEY AUTOINCREMENT, starttime bigint, endtime bigint, status int, project_id int, category_id int, description text); create table if not exists category(modelid INTEGER PRIMARY KEY AUTOINCREMENT, title text, color bigint); create table if not exists project(modelid INTEGER PRIMARY KEY AUTOINCREMENT, title text, category_id int);"];
  }];
}

@end
