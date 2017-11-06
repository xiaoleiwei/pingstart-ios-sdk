//
//  CZCVideoViewController.m
//  CZCMobileAds-iOS
//
//  Created by ht on 2017/8/3.
//  Copyright © 2017年 ht. All rights reserved.
//

#import "CZCVideoViewController.h"
#import "CZCAppIDAndSlotIDCache.h"
#import <CZCMobileAdsSDK/CZCRewardVideoAd.h>

@interface CZCVideoViewController () <UITextFieldDelegate, CZCRewardVideoAdDelegate>

@property (weak, nonatomic) IBOutlet UITextField *appIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *slotIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UILabel *retryLabel;
@property (weak, nonatomic) IBOutlet UILabel *readyLabel;
@property (weak, nonatomic) IBOutlet UILabel *presentLabel;

@property (nonatomic, assign) BOOL isReward;
@property (nonatomic, assign) int rewardAmount;
@property (nonatomic) NSString *rewardCurrency;

@property (nonatomic) CZCAppIDAndSlotIDCache *cache;

@end

@implementation CZCVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Video";

    if ([self.cache getAppIDWithAdType:CZCAdTypeVideo]) {
        self.appIDTextField.text = [self.cache getAppIDWithAdType:CZCAdTypeVideo];
    }

    if ([self.cache getSlotIDWithAdType:CZCAdTypeVideo]) {
        self.slotIDTextField.text = [self.cache getSlotIDWithAdType:CZCAdTypeVideo];
    }
}

- (IBAction)initializeRewardVideo:(id)sender {
    self.loadingLabel.textColor = [UIColor blackColor];

    CZCRewardVideoAd *videoAd = [CZCRewardVideoAd sharedInstance];
    [videoAd loadWithAppID:self.appIDTextField.text slotID:self.slotIDTextField.text];
    [videoAd setUpVideoRequestMaximumValue:[self.numberTextField.text intValue]];
    [CZCRewardVideoAd sharedInstance].delegate = self;
}

- (IBAction)present:(id)sender {
    [[CZCRewardVideoAd sharedInstance] presentFromRootViewController:self];
}

#pragma mark - CZCRewardVideoAdDelegate
- (void)rewardVideoAd:(CZCRewardVideoAd *)rewardVideoAd
       rewardCurrency:(NSString *)rewardCurrency
         rewardAmount:(int)rewardAmount {
    if (rewardAmount == 0) {
        return;
    }

    self.isReward = YES;
    self.rewardCurrency = rewardCurrency;
    self.rewardAmount = rewardAmount;
}

- (void)rewardVideoAdDidReceiveAd:(CZCRewardVideoAd *)rewardVideoAd {
    __weak typeof(self) weakSelf = self;

    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.readyLabel.textColor = [UIColor blackColor];
        weakSelf.errorLabel.textColor = [UIColor lightGrayColor];
        weakSelf.retryLabel.textColor = [UIColor lightGrayColor];
    });
}

- (void)rewardVideoAd:(CZCRewardVideoAd *)rewardVideoAd didFailToLoadWithError:(NSError *)error {
    __weak typeof(self) weakSelf = self;

    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.errorLabel.text = error.localizedFailureReason;
        weakSelf.errorLabel.textColor = [UIColor redColor];
        weakSelf.retryLabel.textColor = [UIColor blackColor];
    });
}

- (void)rewardVideoAdDidStartPlaying:(CZCRewardVideoAd *)rewardVideoAd {
    self.isReward = NO;

    __weak typeof(self) weakSelf = self;

    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.presentLabel.textColor = [UIColor blackColor];
    });
}

- (void)rewardVideoAdDidClose:(CZCRewardVideoAd *)rewardVideoAd {
    __weak typeof(self) weakSelf = self;

    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf reset];
    });

    if (!self.isReward) {
        return;
    }

    UIAlertController *alert = [UIAlertController
        alertControllerWithTitle:[NSString stringWithFormat:@"Get %d %@", self.rewardAmount, self.rewardCurrency]
                         message:nil
                  preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf presentViewController:alert animated:YES completion:nil];
    });
}

- (void)rewardVideoAdWillLeaveApplication:(CZCRewardVideoAd *)rewardVideoAd {
}

- (void)reset {
    self.errorLabel.textColor = [UIColor lightGrayColor];
    self.retryLabel.textColor = [UIColor lightGrayColor];
    self.readyLabel.textColor = [UIColor lightGrayColor];
    self.presentLabel.textColor = [UIColor lightGrayColor];
}

#pragma mark - TextFiled Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.cache cacheAppIDWithAppID:self.appIDTextField.text adType:CZCAdTypeVideo];
    [self.cache cacheAppIDWithSlotID:self.slotIDTextField.text adType:CZCAdTypeVideo];
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
