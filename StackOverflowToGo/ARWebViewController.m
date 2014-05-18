//
//  ARWebViewController.m
//  StackOverflowToGo
//
//  Created by Anton Rivera on 5/17/14.
//  Copyright (c) 2014 Anton Hilario Rivera. All rights reserved.
//

#import "ARWebViewController.h"

@interface ARWebViewController ()

@end

@implementation ARWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:_link] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:604800];
    [_webView loadRequest:urlRequest];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

@end
