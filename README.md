# Solo Mobile Ads SDK for iOS
## Prerequisites
   * Use Xcode 7.0 or higher
   * Target iOS 8.0 or higher

## Import the Mobile Ads SDK
### CocoaPods (preferred)
The simplest way to import the SDK into an iOS project is with CocoaPods. Open your project's Podfile and add this line to your app's target:
```ruby
pod "CZCMobileAdsSDK" 
```
Then from the command line run:
```ruby
pod install --repo-update
```
If you're new to CocoaPods, see their [official documentation](https://guides.cocoapods.org/using/using-cocoapods.html) for info on how to create and use Podfiles.

### Manual download
1.Download and Unzip.

2.Drag the CZCMobileAdsSDK.framework into your project.

3.Add system frameworks.
  * CoreLocation.framework
  * Foundation.framework
  * AVFoundation.framework
  * UIKit.framework
  * SystemConfiguration.framework
  * CoreGraphics.framework
  * Security.framework
  * MobileCoreServices.framework
  * CoreMedia.framework
  * CoreTelephony.framework
  * AdSupport.framework
  * StoreKit.framework
  * WebKit.framework
  
4.Go to Targer->Build Settings->Search for "other linker flags", add "-ObjC" in other linker flags.
## Example
### Banner
```Objective-C
#import <CZCMobileAdsSDK/CZCBannerView.h>

@interface CZCBannerViewController () <CZCBannerViewDelegate>

@property (nonatomic) CZCBannerView *bannerView;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
  // Initialize Solo Mobile Ads SDK
  // Sample Solo appID: 5176_1 slotID:4
  self.bannerView = [[CZCBannerView alloc] initWithAppID:@"AppID"
                                                  slotID:@"SlotID"
                                                position:CZCBannerPositionBottom
                                                delegate:self
                                        rootViewController:self];
  [self.bannerView loadAd];
  
  return YES;
}

```

#### Set up banner event notifications
```Objective-C
#pragma mark - CZCBannerViewDelegate
/// Tells the delegate that start to request an ad.
- (void)adViewRequest:(CZCBannerView *)bannerView {
}

/// Tells the delegate that an ad request successfully received an ad. The delegate may want to add
/// the banner view to the view hierarchy if it hasn't been added yet.
- (void)adViewDidReceiveAd:(CZCBannerView *)bannerView {
}

/// Tells the delegate that an ad request failed. The failure is normally due to network
/// connectivity or ad availablility (i.e., no fill).
- (void)adView:(CZCBannerView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
}

/// Tells the delegate that an ad is clicked.
- (void)adViewDidClick:(CZCBannerView *)bannerView {
}
```

### Interstitial
```Objective-C
#import <CZCMobileAdsSDK/CZCInterstitial.h>

@interface CZCInterstitialViewController () <CZCInterstitialDelegate>

@property (nonatomic) CZCInterstitial *interstitial;

@end

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
  // Initialize Solo Mobile Ads SDK
  // Sample Solo appID: 5176_1 slotID:4
  self.interstitial =
        [[CZCInterstitial alloc] initWithAppID:@"AppID" slotID:@"SlotID" delegate:self];
  
  return YES;
}

```

#### Present interstitial
```Objective-C
[self.interstitial presentFromRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
```

#### Set up interstitial event notifications
```Objective-C
/// Tells the delegate when an interstitial ad request succeeded.
- (void)interstitialDidReceivedAd:(CZCInterstitial *)ad {
}

/// Tells the delegate when an interstitial ad request completed without an interstitial to show.
/// Please check error.localizedFailureReason if want to know detail info.
- (void)interstitial:(CZCInterstitial *)ad didFailToReceiveAdWithError:(NSError *)error {
}

/// Tells the delegate just before presenting an interstitial.After this method finishes the interstitial will
/// animate onto the screen.
- (void)interstitialWillPresentScreen:(CZCInterstitial *)ad {
}

/// Tells the delegate when click an interstitial ad.Skip the appstore after this method finishes.
- (void)interstitialDidClick:(CZCInterstitial *)ad {
}

/// Tells the delegate before the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(CZCInterstitial *)ad {
}
```

### Request rewarded video
```Objective-C
#import <CZCMobileAdsSDK/CZCRewardVideoAd.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
  // Initialize Solo Mobile Ads SDK
  // Sample Solo appID: 5176_1 slotID:4
  [[CZCRewardVideoAd sharedInstance] loadWithAppID:self.appID slotID:self.slotID];
  
  return YES;
}

@end
```
#### Set up video event notifications
```Objective-C
[CZCRewardVideoAd sharedInstance].delegate = self;
```
Here is an example that logs each event available in CZCRewardVideoAdDelegate:
```Objective-C
// Tells the delegate that the reward video ad has rewarded the user.
- (void)rewardVideoAd:(CZCRewardVideoAd *)rewardVideoAd
       rewardCurrency:(NSString *)rewardCurrency
         rewardAmount:(int)rewardAmount {
}

// Tells the delegate that the reward video ad was received.
- (void)rewardVideoAdDidReceiveAd:(CZCRewardVideoAd *)rewardVideoAd {
}

// Tells the delegate that the reward video ad failed to load.
- (void)rewardVideoAd:(CZCRewardVideoAd *)rewardVideoAd didFailToLoadWithError:(NSError *)error {
}

// Tells the delegate that the reward video ad started playing.
- (void)rewardVideoAdDidStartPlaying:(CZCRewardVideoAd *)rewardVideoAd {
}

// Tells the delegate that the reward video ad closed.
- (void)rewardVideoAdDidClose:(CZCRewardVideoAd *)rewardVideoAd {
}

// Tells the delegate that the reward video ad will leave tha application.
- (void)rewardVideoAdWillLeaveApplication:(CZCRewardVideoAd *)rewardVideoAd {
}
```
### Display rewarded video
```Objective-C
if ([[CZCRewardVideoAd sharedInstance] isReady]) {
    [[CZCRewardVideoAd sharedInstance] presentFromRootViewController:self];
}
```
