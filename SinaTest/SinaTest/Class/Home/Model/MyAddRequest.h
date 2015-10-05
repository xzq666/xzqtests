//
//  MyAddRequest.h
//  SinaTest
//
//  Created by 许卓权 on 15/9/29.
//  Copyright © 2015年 许卓权. All rights reserved.
//

#import "AVObject.h"

typedef enum : NSUInteger{
    MyAddRequestStatusWait=0,
    MyAddRequestStatusDone
}MyAddRequestStatus;

#define kAddRequestFromUser @"fromUser"
#define kAddRequestToUser @"toUser"
#define kAddRequestStatus @"status"

@interface MyAddRequest : AVObject<AVSubclassing>

@property AVUser *fromUser;
@property AVUser *toUser;
@property int status;

@end