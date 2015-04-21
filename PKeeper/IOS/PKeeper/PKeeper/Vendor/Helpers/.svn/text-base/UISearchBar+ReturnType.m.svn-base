//
//  UISearchBar+ReturnType.m
//  PRJ_NewSmartBus
//
//  Created by launching on 14-9-24.
//  Copyright (c) 2014年 zhengxing Wang. All rights reserved.
//

#import "UISearchBar+ReturnType.h"

@implementation UISearchBar (ReturnType)

@dynamic returnType;

- (void)setReturnType:(UIReturnKeyType)returnType
{
    for (UIView *searchBarSubview in [self subviews]) {
        if ([searchBarSubview conformsToProtocol:@protocol(UITextInputTraits)]) {
            // Before iOS 7.0
            @try {
                [(UITextField *)searchBarSubview setReturnKeyType:UIReturnKeyDone];
            }
            @catch (NSException * e) {
                // ignore exception
            }
        } else {
            // iOS 7.0
            for(UIView *subSubView in [searchBarSubview subviews]) {
                if([subSubView conformsToProtocol:@protocol(UITextInputTraits)]) {
                    @try {
                        [(UITextField *)subSubView setReturnKeyType:returnType];
                    }
                    @catch (NSException * e) {
                        // ignore exception
                    }
                }
            }
        }
    }
}

@end
