//
//  CZCAppIDAndSlotIDCache.m
//  CZCMobileAds_Example
//
//  Created by ht on 2017/11/3.
//  Copyright © 2017年 xiaoleiwei. All rights reserved.
//

#import "CZCAppIDAndSlotIDCache.h"

static NSString *const bannerAppIDCache = @"BANNNERAPPIDCACHE";
static NSString *const bannerSlotIDCache = @"BANNERSLOTIDCACHE";
static NSString *const interstitialAppIDCache = @"INTERSTITIALAPPIDCACHE";
static NSString *const interstitialSlotIDCache = @"INTERSTITIALSLOTIDCACHE";
static NSString *const videoAppIDCache = @"VIDEOAPPIDCACHE";
static NSString *const videoSlotIDCache = @"VIDEOSLOTIDCACHE";

@implementation CZCAppIDAndSlotIDCache

- (void)cacheAppIDWithAppID:(NSString *)appID adType:(CZCAdType)adType {
    [self cacheID:appID key:[self getKeyWithIsAppID:YES AdType:adType]];
}

- (void)cacheAppIDWithSlotID:(NSString *)slotID adType:(CZCAdType)adType {
    [self cacheID:slotID key:[self getKeyWithIsAppID:NO AdType:adType]];
}

- (NSString *)getKeyWithIsAppID:(BOOL)isAppID AdType:(CZCAdType)adType {
    NSString *key;

    if (isAppID) {
        switch (adType) {
            case CZCAdTypeBanner:
                key = bannerAppIDCache;
                break;
            case CZCAdTypeInterstitial:
                key = interstitialAppIDCache;
                break;
            case CZCAdTypeVideo:
                key = videoAppIDCache;
                break;
        }
        return key;
    }

    switch (adType) {
        case CZCAdTypeBanner:
            key = bannerSlotIDCache;
            break;
        case CZCAdTypeInterstitial:
            key = interstitialSlotIDCache;
            break;
        case CZCAdTypeVideo:
            key = videoSlotIDCache;
            break;
    }

    return key;
}

- (void)cacheID:(NSString *)ID key:(NSString *)key {
    if (!ID || [ID isEqualToString:@""]) {
        return;
    }

    [[NSUserDefaults standardUserDefaults] setObject:ID forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getAppIDWithAdType:(CZCAdType)adType {
    return [[NSUserDefaults standardUserDefaults] objectForKey:[self getKeyWithIsAppID:YES AdType:adType]];
}

- (NSString *)getSlotIDWithAdType:(CZCAdType)adType {
    return [[NSUserDefaults standardUserDefaults] objectForKey:[self getKeyWithIsAppID:NO AdType:adType]];
}

@end
