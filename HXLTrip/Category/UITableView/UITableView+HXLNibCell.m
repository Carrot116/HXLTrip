//
//  UITableView+HXLNibCell.m
//  HXLTrip
//
//  Created by Carrot on 16/7/14.
//  Copyright © 2016年 Carrot. All rights reserved.
//

#import "UITableView+HXLNibCell.h"
#import <objc/runtime.h>

static const char* kHXLUITableViewNibCellKey = "HXLUITableViewNibCellKey";

@implementation UITableView (HXLNibCell)

- (void)hxl_setCellClass:(nonnull Class)cellClass{
    objc_setAssociatedObject(self, kHXLUITableViewNibCellKey, cellClass,OBJC_ASSOCIATION_ASSIGN);
}

- (nullable Class)hxl_cellClass{
    return objc_getAssociatedObject(self, kHXLUITableViewNibCellKey);
}

- (void)hxl_registerCell{
    [self registerClass:[self hxl_cellClass] forCellReuseIdentifier:[self hxl_cellReuseIdentifier]];
    [self registerNib:[self hxl_cellNib] forCellReuseIdentifier:[self hxl_cellReuseIdentifier]];
}

- (UINib*)hxl_cellNib{
    return [UINib nibWithNibName:[self hxl_cellReuseIdentifier] bundle:[NSBundle mainBundle]];
}

- (nullable UITableViewCell*)hxl_cellInstance{
    NSArray* views = [[self hxl_cellNib] instantiateWithOwner:self options:nil];
    NSInteger index = [views indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView* view = (UIView*)obj;
        return [view isKindOfClass:[self hxl_cellClass]];
    }];
    return index == NSNotFound ? nil : views[index];
}

- (nonnull NSString*)hxl_cellReuseIdentifier{
    return NSStringFromClass([self hxl_cellClass]);
}
@end
