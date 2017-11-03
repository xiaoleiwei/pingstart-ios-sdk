//
//  CZCBannerViewController.m
//  CZCMobileAds-iOS
//
//  Created by ht on 2017/8/3.
//  Copyright © 2017年 ht. All rights reserved.
//

#import "CZCBannerViewController.h"
#import <CZCMobileAdsSDK/CZCBannerView.h>

@interface CZCBannerViewController () <CZCBannerViewDelegate>

@property (nonatomic) CZCBannerView *bannerView;
@property (weak, nonatomic) IBOutlet UITextField *appIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *slotIDTextField;

@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UILabel *retryLabel;
@property (weak, nonatomic) IBOutlet UILabel *impressionLabel;

@end

@implementation CZCBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Banner";

    self.bannerView = [[CZCBannerView alloc] initWithAppID:self.appIDTextField.text
                                                    slotID:self.slotIDTextField.text
                                                  position:CZCBannerPositionBottom
                                                  delegate:self
                                        rootViewController:self];
    [self.bannerView disableAutoRefresh];
}

- (IBAction)loadAd:(id)sender {
    self.loadingLabel.textColor = [UIColor blackColor];

    [self.bannerView loadAd];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.bannerView removeFromSuperview];
    self.bannerView = nil;
}

#pragma mark - CZCBannerViewDelegate
- (void)adViewRequest:(CZCBannerView *)bannerView {
    __weak typeof(self) weakSelf = self;

    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.errorLabel.textColor = [UIColor lightGrayColor];
        weakSelf.retryLabel.textColor = [UIColor lightGrayColor];
        weakSelf.impressionLabel.textColor = [UIColor lightGrayColor];
    });
}

- (void)adViewDidReceiveAd:(CZCBannerView *)bannerView {
    __weak typeof(self) weakSelf = self;

    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.impressionLabel.textColor = [UIColor blackColor];
        weakSelf.errorLabel.textColor = [UIColor lightGrayColor];
        weakSelf.retryLabel.textColor = [UIColor lightGrayColor];

        [weakSelf.view addSubview:self.bannerView];
    });
}

- (void)adView:(CZCBannerView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
    __weak typeof(self) weakSelf = self;

    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.errorLabel.text = error.localizedFailureReason;
        weakSelf.errorLabel.textColor = [UIColor redColor];
        weakSelf.retryLabel.textColor = [UIColor blackColor];
    });
}

- (void)adViewDidClick:(CZCBannerView *)bannerView {
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
