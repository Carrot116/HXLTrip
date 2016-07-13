//
//  HXLBannerImageCell.m
//  HXLTrip
//
//  Created by Carrot on 16/7/13.
//  Copyright © 2016年 Carrot. All rights reserved.
//

#import "HXLBannerImageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HXLBannerImageCell ()   

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end


@implementation HXLBannerImageCell
- (void)setImageWithURL:(NSURL*)url placeholderImage:(UIImage*)image{  
    dispatch_async(dispatch_get_main_queue(), ^{
        [_imageView sd_setImageWithURL:url placeholderImage:image];
    });
}

- (void)setImage:(UIImage*)image{
    [self.imageView setImage:image];
}

- (void)setImageNamed:(NSString*)imageName{
    [self.imageView setImage:[UIImage imageNamed:imageName]];
}
@end
