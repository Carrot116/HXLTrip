//
//  HXLStoryBoardLoader.h
//  HXLTrip
//
//  Created by Carrot on 16/7/13.
//  Copyright © 2016年 Carrot. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
/**
 用于使用代码快速初始化Storyboard中的ViewController，并且传递参数
 
 使用注意：
 1.Storyboard中ViewController的StoryboardID需要和它的类名一致 
 
 e.g EPMBuyViewController 的StoryboardID 即是EPMBuyViewController
 
 
 2.传递参数时，自行确认参数类型的匹配，该类未对此进行校验
 
 e.g EPMBuyViewController具有BOOL的属性isBuyGrow，args应该是@{@"isBuyGrow":@(YES)},
 如果将@(YES)改为其他类型，如@"YES",将会导致异常错误，目前未对该错误进行防止崩溃的处理。
 
 **/

#define HXLShortcutViewController(className,StoryboardName,Args) [HXLStoryBoardLoader viewController:className inStoryboard:StoryboardName arguments:Args]

#define HXLShowViewController(className,StoryboardName,Args,NavigationController) \
    do { \
        UIViewController* _controller = [HXLStoryBoardLoader viewController:className inStoryboard:StoryboardName arguments:Args];\
        if (_controller) { \
            [NavigationController pushViewController:_controller animated:YES]; \
        } \
    } while (0)

@interface HXLStoryBoardLoader : NSObject
+ (UIViewController*)viewController:(NSString*)controllerClassName inStoryboard:(NSString*)storyboardName arguments:(NSDictionary*)args;
@end
