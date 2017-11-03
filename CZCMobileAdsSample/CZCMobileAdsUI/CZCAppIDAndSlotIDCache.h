//
//  CZCAppIDAndSlotIDCache.h
//  CZCMobileAds_Example
//
//  Created by 魏晓磊 on 2017/11/3.
//  Copyright © 2017年 xiaoleiwei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CZCAdType) {
    CZCAdTypeBanner = 0,
    CZCAdTypeInterstitial = 1,
    CZCAdTypeVideo = 2,
};

@interface CZCAppIDAndSlotIDCache : NSObject

- (void)cacheAppIDWithAppID:(NSString *)appID adType:(CZCAdType)adType;
- (void)cacheAppIDWithSlotID:(NSString *)slotID adType:(CZCAdType)adType;

- (NSString *)getAppIDWithAdType:(CZCAdType)adType;
- (NSString *)getSlotIDWithAdType:(CZCAdType)adType;

@end
