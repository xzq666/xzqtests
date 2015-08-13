//
//  CDUserService.m
//  xzqtest
//
//  Created by 许卓权 on 15/8/13.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "CDDBManager.h"
#import "CDStatusService.h"
#import "CDStatus.h"
#import "CDUserService.h"
#import "KCSingleton.h"

@interface CDStatusService(){
    
}

@end

@implementation CDStatusService
singleton_implementation(CDStatusService)

-(NSManagedObjectContext *)context{
    return [CDDBManager sharedCDDBManager].context;
}

-(void)addStatusWithCreatedAt:(NSDate *)createdAt source:(NSString *)source text:(NSString *)text user:(CDUser *)user{
    CDStatus *status= [NSEntityDescription insertNewObjectForEntityForName:@"CDStatus" inManagedObjectContext:self.context];
    status.createdAt=createdAt;
    status.source=source;
    status.text=text;
    status.cduser=user;
    NSError *error;
    //保存上下文
    if (![self.context save:&error]) {
        NSLog(@"添加过程中发生错误,错误信息：%@！",error.localizedDescription);
    }
}

-(void)addStatus:(CDStatus *)status{
    [self addStatusWithCreatedAt:status.createdAt source:status.source text:status.text user:status.cduser];
}

-(void)removeStatus:(CDStatus *)status{
    [self.context deleteObject:status];
    NSError *error;
    if (![self.context save:&error]) {
        NSLog(@"删除过程中发生错误,错误信息：%@！",error.localizedDescription);
    }
}

-(NSArray *)getAllStatus{
    NSError *error;
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"CDStatus"];
    NSArray *array=[self.context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"查询过程中发生错误,错误信息：%@！",error.localizedDescription);
    }
    return  array;
}

-(NSArray *)getStatusesByUserName:(NSString *)name{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"CDStatus"];
    request.predicate=[NSPredicate predicateWithFormat:@"user.name=%@",name];
    NSArray *array=[self.context executeFetchRequest:request error:nil];
    return  array;
}

@end