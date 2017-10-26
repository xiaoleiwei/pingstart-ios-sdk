//
//  CZCTableViewController.m
//  CZCMediationSDK-iOS
//
//  Created by ht on 17/6/5.
//  Copyright © 2017年 JiaDingYi. All rights reserved.
//

#import "CZCTableViewController.h"
#import <CZCMobileAdsSDK/CZCLogger.h>

@interface CZCTableViewController ()

@property (nonatomic, nonnull) NSArray *textArray;
@property (nonatomic, nonnull) NSArray *adTypeNameArray;

@end

@implementation CZCTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"SoloAds";
    self.textArray = @[ @"Banner", @"Interstitial", @"Video" ];
    self.adTypeNameArray = @[
        @"CZCBannerViewController",
        @"CZCInterstitialViewController",
        @"CZCVideoViewController",
    ];

    [[CZCLogger stdLogger] setLevel:kLogLevelDebug];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.textArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifuer = @"CZCTableViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifuer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifuer];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    cell.textLabel.text = self.textArray[indexPath.row];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class myClass = NSClassFromString(self.adTypeNameArray[indexPath.row]);
    UIViewController *viewController = (UIViewController *)[myClass new];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
