//
//  HXLBannerImageView.h
//  HXLTrip
//
//  Created by Carrot on 16/7/13.
//  Copyright © 2016年 Carrot. All rights reserved.
//

#import "HXLBannerImageView.h"
#import "HXLBannerImageCell.h"

#import <ReactiveCocoa/ReactiveCocoa.h>


@interface HXLBannerImageView () <UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pagecontrol;

@property (nonatomic, assign) BOOL isCycle;

@end

@implementation HXLBannerImageView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupCollectionView];
    
    self.bannerImages = @[@"http://img5.imgtn.bdimg.com/it/u=488104869,3925974906&fm=21&gp=0.jpg",
                          @"http://img3.imgtn.bdimg.com/it/u=1871619770,2979537917&fm=21&gp=0.jpg",
                          @"http://img0.imgtn.bdimg.com/it/u=990240392,4235913884&fm=21&gp=0.jpg",
                          @"http://img5.imgtn.bdimg.com/it/u=3460836039,1675457946&fm=21&gp=0.jpg"];
    
    [self beginCycle];
}

//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        [self setupCollectionView];
//    }
//    return self;
//}

- (void)setupCollectionView{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[HXLBannerImageCell class] forCellWithReuseIdentifier:NSStringFromClass([HXLBannerImageCell class])];
    UINib* nib = [UINib nibWithNibName:NSStringFromClass([HXLBannerImageCell class]) bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:NSStringFromClass([HXLBannerImageCell class])];
}

- (Class)cellClass{
    return [HXLBannerImageCell class];
}

- (NSString*)cellClassName{
    return NSStringFromClass([self cellClass]);
}

- (UINib*)cellNib{
    return [UINib nibWithNibName:[self cellClassName] bundle:[NSBundle mainBundle]];
}

- (void)setBannerImages:(NSArray *)bannerImages{
    _bannerImages = bannerImages;
    self.pagecontrol.numberOfPages = bannerImages.count;
    [self.collectionView reloadData];
}

- (void)beginCycle
{
    if(self.isCycle)
        return;
    self.isCycle = YES;
    @weakify(self);
    [[[RACSignal interval:6 onScheduler:[RACScheduler mainThreadScheduler]] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        int currentIndex = (int)self.pagecontrol.currentPage;
        int nextIndex = currentIndex + 1;
        if(nextIndex > self.bannerImages.count - 1)
            nextIndex = 0;
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat offset = nextIndex * self.collectionView.frame.size.width;
            [self.collectionView setContentOffset:CGPointMake(offset, 0) animated:YES];
        });
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.bannerImages ? self.bannerImages.count : 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HXLBannerImageCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self cellClassName] forIndexPath:indexPath];
    if (!cell) {
        cell = [[self cellNib] instantiateWithOwner:self options:nil].firstObject;
    }
    [cell setImageWithURL:[NSURL URLWithString:self.bannerImages[indexPath.row]] placeholderImage:[UIImage imageNamed:@"banner01"]];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.bounds.size;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _pagecontrol.currentPage = scrollView.contentOffset.x / _collectionView.frame.size.width;
}

@end
