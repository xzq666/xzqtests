//
//  MyEmotion.m
//  SinaTest
//
//  Created by 许卓权 on 15/9/28.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "MyEmotion.h"
#import "NSString+Emoji.h"

@implementation MyEmotion

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - %@ - %@", self.chs , self.png , self.copy ];
}

- (void)setCode:(NSString *)code {
    _code = [code copy];
    if(!code) return;
    self.emoji = [NSString emojiWithStringCode:code];
}

// 当文件中解析出一个对象的时候调用，在这个方法中写清楚：怎么解析文件中的数据
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]){
        self.chs = [decoder decodeObjectForKey:@"chs"];
        self.png = [decoder decodeObjectForKey:@"png"];
        self.code = [decoder decodeObjectForKey:@"code"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.chs forKey:@"chs"];
    [encoder encodeObject:self.png forKey:@"png"];
    [encoder encodeObject:self.code forKey:@"code"];
}

- (BOOL)isEqual:(MyEmotion *)emotion {
    if (emotion.code) {
        return [self.code isEqualToString:emotion.code];
    }else{
        return [self.png isEqualToString:emotion.png] && [self.chs isEqualToString:emotion.chs];
    }
}

@end