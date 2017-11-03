//
//  CZCInterstitialViewController.m
//  CZCMobileAds-iOS
//
//  Created by ht on 2017/8/3.
//  Copyright © 2017年 ht. All rights reserved.
//

#import "CZCInterstitialViewController.h"
#import "CZCAppIDAndSlotIDCache.h"
#import <CZCMobileAdsSDK/CZCInterstitial.h>

@interface CZCInterstitialViewController () <CZCInterstitialDelegate, UITextFieldDelegate>

@property (nonatomic) CZCInterstitial *interstitial;
@property (weak, nonatomic) IBOutlet UITextField *appIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *slotIDTextField;

@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UILabel *retryLabel;
@property (weak, nonatomic) IBOutlet UILabel *readyLabel;
@property (weak, nonatomic) IBOutlet UILabel *presentLabel;

@property (nonatomic) CZCAppIDAndSlotIDCache *cache;

@end

@implementation CZCInterstitialViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if ([self.cache getAppIDWithAdType:CZCAdTypeInterstitial]) {
        self.appIDTextField.text = [self.cache getAppIDWithAdType:CZCAdTypeInterstitial];
    }

    if ([self.cache getSlotIDWithAdType:CZCAdTypeInterstitial]) {
        self.slotIDTextField.text = [self.cache getSlotIDWithAdType:CZCAdTypeInterstitial];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Interstitial";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    self.interstitial = nil;
}

- (IBAction)loadInterstitial:(id)sender {
    self.loadingLabel.textColor = [UIColor blackColor];

    self.interstitial =
        [[CZCInterstitial alloc] initWithAppID:self.appIDTextField.text slotID:self.slotIDTextField.text delegate:self];
}

- (IBAction)present:(id)sender {
    [self.interstitial presentFromRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

#pragma mark - CZCInterstitialDelegate
- (void)interstitialDidReceivedAd:(CZCInterstitial *)ad {
    __weak typeof(self) weakSelf = self;

    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.readyLabel.textColor = [UIColor blackColor];
        weakSelf.errorLabel.textColor = [UIColor lightGrayColor];
        weakSelf.retryLabel.textColor = [UIColor lightGrayColor];
    });
}

- (void)interstitial:(CZCInterstitial *)ad didFailToReceiveAdWithError:(NSError *)error {
    __weak typeof(self) weakSelf = self;

    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.errorLabel.text = error.localizedFailureReason;
        weakSelf.errorLabel.textColor = [UIColor redColor];
        weakSelf.retryLabel.textColor = [UIColor blackColor];
    });
}

- (void)interstitialWillPresentScreen:(CZCInterstitial *)ad {
    __weak typeof(self) weakSelf = self;

    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.presentLabel.textColor = [UIColor blackColor];
    });
}

- (void)interstitialDidClick:(CZCInterstitial *)ad {
}

- (void)interstitialWillDismissScreen:(CZCInterstitial *)ad {
    __weak typeof(self) weakSelf = self;

    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf reset];
    });
}

- (void)reset {
    self.errorLabel.textColor = [UIColor lightGrayColor];
    self.retryLabel.textColor = [UIColor lightGrayColor];
    self.readyLabel.textColor = [UIColor lightGrayColor];
    self.presentLabel.textColor = [UIColor lightGrayColor];
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.cache cacheAppIDWithAppID:self.appIDTextField.text adType:CZCAdTypeInterstitial];
    [self.cache cacheAppIDWithSlotID:self.slotIDTextField.text adType:CZCAdTypeInterstitial];
}

- (CZCAppIDAndSlotIDCache *)cache {
    if (!_cache) {
        _cache = [[CZCAppIDAndSlotIDCache alloc] init];
    }

    return _cache;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
