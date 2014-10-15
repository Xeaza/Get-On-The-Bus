//
//  BusStopDetailViewController.m
//  Get On The Bus
//
//  Created by Taylor Wright-Sanson on 10/14/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "BusStopDetailViewController.h"

@interface BusStopDetailViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *routes;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIImageView *connectionImageView;

@end

@implementation BusStopDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.busStopAnnotation.title;
    self.routes.text = [@"Routes: " stringByAppendingString:self.busStopAnnotation.routes];
    if (self.busStopAnnotation.interModal)
    {
        if ([self.busStopAnnotation.interModal isEqualToString:@"Metra"])
        {
            self.connectionImageView.image = [UIImage imageNamed:@"metra"];
        }
        else
        {
            self.connectionImageView.image = [UIImage imageNamed:@"pace"];
        }
    }
    else {
        self.connectionImageView.image = [UIImage imageNamed:@"no_connection"];
    }

    [self loadWebView];
}

- (void)loadWebView
{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:self.busStopAnnotation.addressUrl];
    [self.webView loadRequest:urlRequest];
}

#pragma mark - WebView Delegate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
