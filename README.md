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

1.Download and Unzip

2.Drag the CZCMobileAdsSDK.framework into your project

3.Add system frameworks
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
  
4.Go to Targer->Build Settings->Search for "other linker flags", add "-ObjC" in other linker flags

## Example
