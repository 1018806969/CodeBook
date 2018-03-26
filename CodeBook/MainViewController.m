//
//  MainViewController.m
//  CodeBook
//
//  Created by Merlin on 2018/3/17.
//  Copyright © 2018年 lq. All rights reserved.
//

#import "MainViewController.h"
#import "PlatformDetailViewController.h"
#import "WebViewController.h"
#import "PlatformCell.h"
#import "MainViewModel.h"
#import "Platform.h"

static NSString *const kPlatformCellID = @"kPlatformCellID";
@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MainViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isInsert;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"密码表";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    
    [self.view addSubview:self.tableView];
    self.viewModel = [[MainViewModel alloc] init];
    [self.viewModel loadPlatforms];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _viewModel.platforms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlatformCell *cell = [tableView dequeueReusableCellWithIdentifier:kPlatformCellID];
    [cell loadPlatform:_viewModel.platforms[indexPath.row] link:^(NSString *url) {
        WebViewController *webVc = [[WebViewController alloc] initWithUrl:url];
        [self.navigationController pushViewController:webVc animated:YES];
    }];
    return cell;
}

- (void)deleteAction
{
    _isInsert = NO;
    [self.tableView setEditing:!_tableView.editing animated:YES];
}

- (void)addAction
{
    _isInsert = YES;
    if (self.viewModel.platforms && self.viewModel.platforms.count) {
        [self.tableView setEditing:!_tableView.editing animated:YES];
    } else {
        [self toPlatformDetailVCWithPlatform:nil];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _isInsert ? UITableViewCellEditingStyleInsert : UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.viewModel moveRowAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.viewModel deletePlatformAtIndex:indexPath.row];
        [self.tableView reloadData];
    } else {
        [self toPlatformDetailVCWithPlatform:nil];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self toPlatformDetailVCWithPlatform:_viewModel.platforms[indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Platform *platform = self.viewModel.platforms[indexPath.row];
    return 137 + platform.descriptionHeight;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:@"PlatformCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kPlatformCellID];
        _tableView.rowHeight = 137;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (void)toPlatformDetailVCWithPlatform:(Platform *)platform
{
    PlatformDetailViewController *platformDetailVc = [[PlatformDetailViewController alloc] initWithPlatform:platform editScc:^(Platform *platform) {
        [self.viewModel addPlatform:platform];
        [self.tableView reloadData];
    }];
    [self.navigationController pushViewController:platformDetailVc animated:YES];
}

@end
