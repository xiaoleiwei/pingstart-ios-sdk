//
//  CZCVideoDetailViewController.m
//  CZCMobileAds
//
//  Created by 魏晓磊 on 2017/9/14.
//  Copyright © 2017年 xiaoleiwei. All rights reserved.
//

#import "CZCVideoDetailViewController.h"
#import <CZCMobileAdsSDK/CZCRewardVideoAd.h>

@interface CZCVideoDetailViewController () <CZCRewardVideoAdDelegate>

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UITextView *logTextView;

@property (nonatomic, assign) BOOL isReward;
@property (nonatomic, assign) int rewardAmount;
@property (nonatomic) NSString *rewardCurrency;

@property (nonatomic) NSString *log;

@end

@implementation CZCVideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Log";

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(printLog:) name:@"CZC_LOG" object:nil];

    [self loadVideoAd];
}

- (void)loadVideoAd {
    CZCRewardVideoAd *videoAd = [CZCRewardVideoAd sharedInstance];
    [videoAd loadWithAppID:self.appID slotID:self.slotID];
    [videoAd setUpVideoRequestMaximumValue:self.maxinumVideoAds];
    [CZCRewardVideoAd sharedInstance].delegate = self;

    if ([[CZCRewardVideoAd sharedInstance] isReady]) {
        return;
    }
    self.playButton.enabled = NO;
}

- (IBAction)isReadyForRewardVideo:(id)sender {
    NSString *alertTitle =
        [NSString stringWithFormat:@"%@", [[CZCRewardVideoAd sharedInstance] isReady] ? @"Can play" : @"No ready"];
    UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:alertTitle message:nil preferredStyle:UIAlertControllerStyleAlert];
    if ([[CZCRewardVideoAd sharedInstance] isReady]) {
        [alert addAction:[UIAlertAction actionWithTitle:@"Not play"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *_Nonnull action){

                                                }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"Play"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *_Nonnull action) {
                                                    [[CZCRewardVideoAd sharedInstance]
                                                        presentFromRootViewController:self];
                                                }]];
    } else {
        [alert addAction:[UIAlertAction actionWithTitle:@"Please wait"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *_Nonnull action){

                                                }]];
    }
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)playRewardVideo:(id)sender {
    [[CZCRewardVideoAd sharedInstance] presentFromRootViewController:self];
}

- (void)printLog:(NSNotification *)nf {
    NSString *msg = [nf object];

    self.log = [NSString stringWithFormat:@"%@\n%@", self.log, msg];

    dispatch_async(dispatch_get_main_queue(), ^{
        self.logTextView.text = self.log;
    });
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - CZCRewardVideoAdDelegate
// Tells the delegate that the reward video ad has rewarded the user.
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

// Tells the delegate that the reward video ad was received.
- (void)rewardVideoAdDidReceiveAd:(CZCRewardVideoAd *)rewardVideoAd {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.playButton.enabled = YES;
    });
}

// Tells the delegate that the reward video ad failed to load.
- (void)rewardVideoAd:(CZCRewardVideoAd *)rewardVideoAd didFailToLoadWithError:(NSError *)error {
}

// Tells the delegate that the reward video ad started playing.
- (void)rewardVideoAdDidStartPlaying:(CZCRewardVideoAd *)rewardVideoAd {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.playButton.enabled = NO;
        self.isReward = NO;
    });
}

// Tells the delegate that the reward video ad closed.
- (void)rewardVideoAdDidClose:(CZCRewardVideoAd *)rewardVideoAd {
    if (!self.isReward) {
        return;
    }

    UIAlertController *alert = [UIAlertController
        alertControllerWithTitle:[NSString stringWithFormat:@"Get %d %@", self.rewardAmount, self.rewardCurrency]
                         message:nil
                  preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

// Tells the delegate that the reward video ad will leave tha application.
- (void)rewardVideoAdWillLeaveApplication:(CZCRewardVideoAd *)rewardVideoAd {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
