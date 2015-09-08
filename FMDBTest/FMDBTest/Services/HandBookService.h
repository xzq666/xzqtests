//
//  HandBookService.h
//  FMDBTest
//
//  Created by 许卓权 on 15/9/7.
//  Copyright (c) 2015年 CCT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HandBook.h"
#import "XZQSingleton.h"

@interface HandBookService : NSObject

singleton_interface(HandBookService)

/*
 *  添加图鉴
 *  @param handbook 图鉴对象
 */
- (void)addHandBook:(HandBook *)handbook;

/*
 *  删除图鉴
 *  @param handbook 图鉴对象
 */
- (void)removeHandBook:(HandBook *)handbook;

/*
 *  根据图鉴名删除图鉴
 *  @param name 图鉴名
 */
- (void)removeHandBookByName:(NSString *)name;

/*
 *  修改图鉴内容
 *  @param handbook 图鉴对象
 */
- (void)modifyHandBook:(HandBook *)handbook;

/*
 *  根据图鉴编号取得图鉴
 *  @param Id 图鉴编号
 */
- (HandBook *)getHandBookById:(int)Id;

/*
 *  根据图鉴名取得图鉴
 *  @param handbook 图鉴对象
 */
- (HandBook *)getHandBookByName:(NSString *)name;

/*
 *  取得所有图鉴
 */
- (NSArray *)getAllHandBook;

@end