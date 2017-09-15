//
//  CZCRewardVideoAd.h
//  CZCMobileAds-iOS
//
//  Created by ht on 2017/7/28.
//  Copyright © 2017年 ht. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CZCRewardVideoAdDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface CZCRewardVideoAd : NSObject

/// Delegate to receive video notifications.
@property (nonatomic, weak, nullable) id<CZCRewardVideoAdDelegate> delegate;

/// Return the shared CZCRewardVideoAd instance.
+ (CZCRewardVideoAd *)sharedInstance;

/// Initiates the request to fetch the reward video ad.
/// The appID and slotID is used for fetching an ad and must not be nil.
- (void)loadWithAppID:(NSString *)appID slotID:(NSString *)slotID;

/// Indicates if the receiver is ready to presented video.
- (BOOL)isReady;

/// Presents the reward video ad with the provided view controller.
- (void)presentFromRootViewController:(UIViewController *)viewController;

/// Maximum value that request video ad once.
/// Default one if not set.
- (void)setUpVideoRequestMaximumValue:(NSUInteger)max;

/// The value passed as 'user' in the an incentivized server-to-server call.
- (void)setUpUserID:(NSString *)userID;

@end

NS_ASSUME_NONNULL_END
