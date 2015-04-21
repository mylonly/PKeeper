//
//  PKNewsModel.m
//  PKeeper
//
//  Created by mylonly on 15/3/13.
//  Copyright (c) 2015年 www.mylonly.com. All rights reserved.
//

#import "PKNewsModel.h"

@implementation PKNewsModel

- (id)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        _newsID = [[dict valueForKey:@"id"] asNSString];
        _newsTitle = [[dict valueForKey:@"title"] asNSString];
        
        NSArray* attachs = [[dict valueForKey:@"attachments"] asNSArray];
        for (NSDictionary* dict in  attachs)
        {
            NSString* type = [[dict valueForKey:@"type"] asNSString];
            if ([type isEqualToString:@"pic"] || [type isEqualToString:@"file"])
            {
                NSString* urlPath = [[dict valueForKey:@"attachAddr"] asNSString];
                _newsThumbUrl =[NSURL URLWithString:urlPath];
            }
            else if([type isEqualToString:@"video"])
            {
                NSString* urlPath = [[dict valueForKey:@"attachAddr"] asNSString];
                _newsVideoUrl =[NSURL URLWithString:urlPath];
            }
        }
        _newsSummary = [[dict valueForKey:@"docabstract"] asNSString];
        _newsCreatedTime = [dict valueForKey:@"publishtime"];
        _newsWebUrl = NEWS_URL(_newsID);
    }
    return self;
}

@end
