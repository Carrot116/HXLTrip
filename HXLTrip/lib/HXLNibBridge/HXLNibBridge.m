//
//  HXLNibBridge.h
//  lib
//
//  Created by Carrot on 16/7/13.
//  Copyright © 2016年 Carrot. All rights reserved.
//

#import "HXLNibBridge.h"
#import <objc/runtime.h>

@interface UIView (HXLNibBridge)
- (nonnull instancetype)initHackWithCoder:(NSCoder*)aDecoder;
@end

@implementation UIView(HXLNibBridge)
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(initWithCoder:);
        SEL swizzledSelector = @selector(initHackWithCoder:);
        Method originalMethod = class_getInstanceMethod(UIView.class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        if (class_addMethod(UIView.class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
            class_replaceMethod(UIView.class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (nonnull instancetype)initHackWithCoder:(NSCoder *)aDecoder{
    self = [self initHackWithCoder:aDecoder];
    if (self) {
        [self hxl_setupViewFromNib];
    }
    return self;
}

- (void)hxl_setupViewFromNib{
    if ([self conformsToProtocol:@protocol(HXLNibBridge)] && self.subviews.count == 0) {
        if ([self respondsToSelector:@selector(hxl_willInitViewWithNibBridge)]) {
            [self performSelector:@selector(hxl_willInitViewWithNibBridge)];
        }
        UIView* view = [self hxl_instantiateSubviewFromNib];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:view];
        [self addConstraints:@[
                               [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeTop multiplier:1 constant:0],
                               [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
                               [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
                               [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeRight multiplier:1 constant:0]
                               ]];
        if ([self respondsToSelector:@selector(hxl_didInitViewWithNibBridge)]) {
            [self performSelector:@selector(hxl_didInitViewWithNibBridge)];
        }
    }
}

- (UIView*)hxl_instantiateSubviewFromNib{
    NSBundle* bundle;
    if ([self respondsToSelector:@selector(hxl_bundleOfURLForResourceWithFloderName)]) {
        NSString* floderName = [self performSelector:@selector(hxl_bundleOfURLForResourceWithFloderName)];
        bundle = [NSBundle bundleWithURL:[[NSBundle bundleForClass:[self class]] URLForResource:floderName withExtension:@"bundle"]];
    } else {
        bundle = [NSBundle bundleForClass:[self class]];
    }
    
    UINib* nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:bundle];
    NSArray* views = [nib instantiateWithOwner:self options:nil];
    NSUInteger index = [views indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [obj isKindOfClass:[UIView class]];
    }];
    return (index == NSNotFound) ? nil : views[index];
}

@end

@implementation UIView (HXLNibConvertion)

+ (nonnull instancetype)hxl_instantiateFromNib{
    id instance = [[self class] new];
    if (instance) {
        UIView* view = (UIView*)instance;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [view hxl_setupViewFromNib];
    }
    return nil;
}

@end
