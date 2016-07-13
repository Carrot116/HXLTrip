//
//  HXLBannerImageCell.h
//  HXLTrip
//
//  Created by Carrot on 16/7/13.
//  Copyright © 2016年 Carrot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXLNibBridge.h"

@interface HXLBannerImageCell : UICollectionViewCell<HXLNibBridge>
- (void)setImageWithURL:(NSURL*)url placeholderImage:(UIImage*)image;
- (void)setImage:(UIImage*)image;
- (void)setImageNamed:(NSString*)imageName;
@end
