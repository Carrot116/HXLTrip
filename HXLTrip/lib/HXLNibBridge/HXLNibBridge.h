//
//  HXLNibBridge.h
//  lib
//
//  Created by Carrot on 16/7/13.
//  Copyright © 2016年 Carrot. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HXLNibBridge <NSObject>

@optional
- (nullable NSString*)hxl_bundleOfURLForResourceWithFloderName;
- (void)hxl_willInitViewWithNibBridge;
- (void)hxl_didInitViewWithNibBridge;

@end

@interface UIView (HXLNibConvertion)
+ (nonnull instancetype)hxl_instantiateFromNib;
@end
