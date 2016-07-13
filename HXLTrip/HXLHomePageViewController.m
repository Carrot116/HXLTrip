//
//  HXLHomePageViewController.m
//  HXLTrip
//
//  Created by Carrot on 16/7/13.
//  Copyright © 2016年 Carrot. All rights reserved.
//

#import "HXLHomePageViewController.h"
#import "HXLBannerImageView.h"

@interface HXLHomePageViewController ()  <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topContainer;
@property (weak, nonatomic) IBOutlet UIView *topSearchView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet HXLBannerImageView *bannerView;

@end

@implementation HXLHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    CGRect rcScreen = [UIScreen mainScreen].bounds;
//    UIView* headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, rcScreen.size.width, 120)];
//    UIView* headView = [[HXLBannerImageView hxl_instantiateFromNib]initWithFrame:CGRectMake(0, 0, rcScreen.size.width, 120)];
//    headView.backgroundColor = [UIColor blueColor];
//    self.tableView.tableHeaderView = headView;
    self.tableView.tableHeaderView = self.bannerView;
    
    self.topContainer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
//    [self.bannerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"%@", NSStringFromClass([obj class]));
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld Row", (long)indexPath.row ];
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y){
        self.topContainer.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:scrollView.contentOffset.y / 64];
    }
}

@end
