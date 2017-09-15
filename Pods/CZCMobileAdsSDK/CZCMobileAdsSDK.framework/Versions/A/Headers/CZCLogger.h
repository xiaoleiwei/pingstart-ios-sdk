//
//  CZCLogger.h
//  CZCMobileAds-iOS
//
//  Created by ht on 2017/8/2.
//  Copyright © 2017年 ht. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CZCLogLevel) {
    kLogLevelNone = -1,
    kLogLevelError = 0,
    kLogLevelWarning = 1,
    kLogLevelInfo = 2,
    kLogLevelDebug = 3,
};

#define CZCStdLogger [CZCLogger stdLogger]

@interface CZCLogger : NSObject

+ (instancetype)stdLogger;

- (void)setLevel:(CZCLogLevel)level;

- (void)debug:(NSString *)message;
- (void)info:(NSString *)message;
- (void)warning:(NSString *)message;
- (void)error:(NSString *)message;

@end
