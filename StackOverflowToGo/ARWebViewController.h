//
//  ARWebViewController.h
//  StackOverflowToGo
//
//  Created by Anton Rivera on 5/17/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARSearchResult.h"

@interface ARWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) ARSearchResult *searchResult;
@property (nonatomic, strong) NSString *link;

@end
