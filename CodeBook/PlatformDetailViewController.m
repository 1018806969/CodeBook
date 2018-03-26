//
//  PlatformDetailViewController.m
//  CodeBook
//
//  Created by Merlin on 2018/3/18.
//  Copyright © 2018年 lq. All rights reserved.
//

#import "PlatformDetailViewController.h"
#import "Platform.h"

@interface PlatformDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPswTextField;
@property (weak, nonatomic) IBOutlet UITextField *otherPswTextField;
@property (weak, nonatomic) IBOutlet UITextField *platformNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *platformAddressTextField;
@property (weak, nonatomic) IBOutlet UITextView *platformDescriptionTextView;

@property (nonatomic, copy) void(^scc)(Platform *platform);
@property (nonatomic, strong) Platform *platform;

@end

@implementation PlatformDetailViewController

- (instancetype)initWithPlatform:(Platform *)platform editScc:(void (^)(Platform *))scc
{
    self = [super init];
    if (self) {
        self = [[PlatformDetailViewController alloc] init];
        self.scc = [scc copy];
        self.platform = platform;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction:)];

    if (_platform) {
        _userPswTextField.text = _platform.userPsw;
        _userNameTextField.text = _platform.userName;
        _otherPswTextField.text = _platform.otherPsw;
        _platformNameTextField.text = _platform.platformName;
        _platformAddressTextField.text = _platform.platformAddress;
        _platformDescriptionTextView.text = _platform.platformDescription;
    }
}

- (IBAction)saveAction:(id)sender
{
    if (!self.scc) return;
    
    if (_platform) {
        if (_userPswTextField.text == _platform.userPsw &&
            _userNameTextField.text == _platform.userName &&
            _otherPswTextField.text == _platform.otherPsw &&
            _platformNameTextField.text == _platform.platformName &&
            _platformAddressTextField.text == _platform.platformAddress &&
            _platformDescriptionTextView.text == _platform.platformDescription) return;
        self.scc(_platform);
    } else {
        Platform *platform = [[Platform alloc] init];
        platform.userName = _userNameTextField.text;
        platform.userPsw = _userPswTextField.text;
        platform.otherPsw = _otherPswTextField.text;
        platform.platformName = _platformNameTextField.text;
        platform.platformAddress = _platformAddressTextField.text;
        platform.platformDescription = _platformDescriptionTextView.text;
        self.scc(platform);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
