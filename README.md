# Solo Mobile Ads SDK for iOS

## 1.Integration SDK

### Integration by CocoaPods

CZCMobileAdsSDK is available through CocoaPods. To install it, simply add the following line to your Podfile.

```ruby
# Default download lastest sdk
pod "CZCMobileAdsSDK" 

# The specified version
pod "CZCMobileAdsSDK",'~> 1.0'
```
### Integration by downloading SDK

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
