//
//  HandBook.h
//  FMDBTest
//
//  Created by 许卓权 on 15/9/7.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HandBook : NSObject

#pragma mark 编号
@property (nonatomic,strong) NSNumber *Id;

#pragma mark 英雄名称
@property (nonatomic,strong) NSString *name;

#pragma mark 英雄星级
@property (nonatomic,strong) NSString *star;

#pragma mark 英雄图片url
@property (nonatomic,strong) NSString *imgurl;

/*
 *  初始化
 *  @param name star imgurl
 *  @return 图鉴对象
 */
- (HandBook *) initWithName:(NSString *)name star:(NSString *)star imgurl:(NSString *)imgurl;

/*
 *  使用字典初始化
 *  @param dic
 *  @return 图鉴对象
 */
- (HandBook *) initWithDictionary:(NSDictionary *)dic;

/*
 *  静态初始化
 *  @param name star imgurl
 *  @return 图鉴对象
 */
+ (HandBook *) handbookWithName:(NSString *)name star:(NSString *)star imgurl:(NSString *)imgurl;

@end