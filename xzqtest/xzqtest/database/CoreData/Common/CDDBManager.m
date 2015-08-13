//
//  CDDBManager.m
//  xzqtest
//
//  Created by 许卓权 on 15/8/13.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import "CDDBManager.h"
#import <CoreData/CoreData.h>
#import "KCSingleton.h"

@interface CDDBManager()
@end

@implementation CDDBManager

singleton_implementation(CDDBManager)

#pragma mark 重写初始化方法
-(instancetype)init{
    CDDBManager *manager;
    if((manager=[super init])) {
        _context=[manager createDbContext];
    }
    return manager;
}

-(NSManagedObjectContext *)createDbContext{
    NSManagedObjectContext *context;
    //打开模型文件，参数为nil则打开包中所有模型文件并合并成一个
    NSManagedObjectModel *model=[NSManagedObjectModel mergedModelFromBundles:nil];
    //创建解析器
    NSPersistentStoreCoordinator *storeCoordinator=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    //创建数据库保存路径
    NSString *dir=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"%@",dir);
    NSString *path=[dir stringByAppendingPathComponent:@"myDatabase.db"];
    NSURL *url=[NSURL fileURLWithPath:path];
    //添加SQLite持久存储到解析器
    NSError *error;
    [storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if(error){
        NSLog(@"数据库打开失败！错误:%@",error.localizedDescription);
    }else{
        context=[[NSManagedObjectContext alloc]init];
        context.persistentStoreCoordinator=storeCoordinator;
        NSLog(@"数据库打开成功！");
    }
    return context;
}

@end