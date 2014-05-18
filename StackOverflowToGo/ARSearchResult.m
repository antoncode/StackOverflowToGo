//
//  ARSearchResult.m
//  StackOverflowToGo
//
//  Created by Anton Rivera on 5/17/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARSearchResult.h"

@implementation ARSearchResult

- (instancetype)initWithTitle:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        self.title = [dictionary objectForKey:@"title"];
        self.link = [dictionary objectForKey:@"link"];
    }
    return self;
}

@end
