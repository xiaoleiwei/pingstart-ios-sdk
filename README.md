# Solo Mobile Ads reward video SDK for iOS
Rewarded video ads are full-screen video ads that users have the option of watching in full in exchange for in-app rewards.
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
  
4.Go to Targer->Build Settings->Search for "other linker flags", add "-ObjC" in other linker flags.
## Example
### Request rewarded video
```Objective-C
#import <CZCMobileAdsSDK/CZCRewardVideoAd.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
  // Initialize Solo Mobile Ads SDK
  // Sample Solo appID: 5176_1 slotID:4
  [[CZCRewardVideoAd sharedInstance] loadWithAppID:self.appID slotID:self.slotID delegate:self];
  
  return YES;
}

@end
```
### Set up event notifications
```Objective-C
[GADRewardBasedVideoAd sharedInstance].delegate = self;
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
