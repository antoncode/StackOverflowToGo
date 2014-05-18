//
//  ARSearchResult.h
//  StackOverflowToGo
//
//  Created by Anton Rivera on 5/17/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARSearchResult : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *link;

- (instancetype)initWithTitle:(NSDictionary *)dictionary;

@end
