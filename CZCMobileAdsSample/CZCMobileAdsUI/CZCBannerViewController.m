//
//  CZCBannerViewController.m
//  CZCMobileAds-iOS
//
//  Created by ht on 2017/8/3.
//  Copyright © 2017年 ht. All rights reserved.
//

#import "CZCBannerViewController.h"
#import  <CZCMobileAdsSDK/CZCBannerView.h>

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
    self.errorLabel.textColor = [UIColor lightGrayColor];
    self.retryLabel.textColor = [UIColor lightGrayColor];
    self.impressionLabel.textColor = [UIColor lightGrayColor];
}

- (void)adViewDidReceiveAd:(CZCBannerView *)bannerView {
    [self.view addSubview:self.bannerView];
    
    self.impressionLabel.textColor = [UIColor blackColor];
    self.errorLabel.textColor = [UIColor lightGrayColor];
    self.retryLabel.textColor = [UIColor lightGrayColor];
}

- (void)adView:(CZCBannerView *)bannerView didFailToReceiveAdWithError:(NSError *)error {
    self.errorLabel.text = error.localizedFailureReason;
    self.errorLabel.textColor = [UIColor redColor];
    self.retryLabel.textColor = [UIColor blackColor];
}

- (void)adViewDidClick:(CZCBannerView *)bannerView {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
