//
//  HXLBannerImageView.h
//  HXLTrip
//
//  Created by Carrot on 16/7/13.
//  Copyright © 2016年 Carrot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXLNibBridge.h"

@interface HXLBannerImageView : UIView<HXLNibBridge>
@property (nonatomic, strong) NSArray* bannerImages;
@end
