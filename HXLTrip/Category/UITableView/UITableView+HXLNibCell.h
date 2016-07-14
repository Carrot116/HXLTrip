//
//  UITableView+HXLNibCell.h
//  HXLTrip
//
//  Created by Carrot on 16/7/14.
//  Copyright © 2016年 Carrot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (HXLNibCell)
- (void)hxl_setCellClass:(nonnull Class)cellClass;
- (nullable Class)hxl_cellClass;
- (nullable UITableViewCell*)hxl_cellInstance;
- (nonnull NSString*)hxl_cellReuseIdentifier;
@end
