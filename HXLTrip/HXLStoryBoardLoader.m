//
//  HXLStoryBoardLoader.m
//  HXLTrip
//
//  Created by Carrot on 16/7/13.
//  Copyright © 2016年 Carrot. All rights reserved.
//

#import "HXLStoryBoardLoader.h"
#import <objc/runtime.h>

@implementation HXLStoryBoardLoader
+ (UIViewController*)viewController:(NSString*)controllerClassName inStoryboard:(NSString*)storyboardName arguments:(NSDictionary*)args{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
    assert(storyboard != nil);
    UIViewController* controller = [storyboard instantiateViewControllerWithIdentifier:controllerClassName];
    assert(controller != nil);
    if(args && [args count] > 0)
    {
        //bind property values
        unsigned int propertyCount = 0;
        objc_property_t* properties = class_copyPropertyList([controller class], &propertyCount);
        for(int i=0;i<propertyCount;i++)
        {
            objc_property_t property = *(properties + i);
            const char* propertyName = property_getName(property);
            NSString* propertyNameNS = [NSString stringWithUTF8String:propertyName];
            if(args[propertyNameNS])
            {
                [controller setValue:args[propertyNameNS] forKeyPath:propertyNameNS];
            }
        }
    }
    return controller;
}
@end
