//
//  CZCVideoViewController.m
//  CZCMobileAds-iOS
//
//  Created by ht on 2017/8/3.
//  Copyright © 2017年 ht. All rights reserved.
//

#import "CZCVideoViewController.h"
#import "CZCVideoDetailViewController.h"

@interface CZCVideoViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *appIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *slotIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@end

@implementation CZCVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Video";
}

- (IBAction)initializeRewardVideo:(id)sender {
    CZCVideoDetailViewController *vDetail =
        [[CZCVideoDetailViewController alloc] initWithNibName:@"CZCVideoDetailViewController" bundle:nil];
    vDetail.appID = self.appIDTextField.text;
    vDetail.slotID = self.slotIDTextField.text;
    vDetail.maxinumVideoAds = [self.numberTextField.text integerValue];
    [self.navigationController pushViewController:vDetail animated:YES];
}

#pragma mark - TextFiled Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
