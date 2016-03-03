//
//  TFDataBase.h
//  TimeFlow
//
//  Created by lorabit on 16/3/4.
//
//

#import <Foundation/Foundation.h>

@interface TFDataBase : NSObject

@property(nonatomic,strong)FMDatabaseQueue* queue;

+(TFDataBase*)db;


@end
