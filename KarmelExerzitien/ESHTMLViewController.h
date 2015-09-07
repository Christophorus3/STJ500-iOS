//
//  ESHTMLViewController.h
//  FastenKalender
//
//  Created by Christoph Wottawa on 07.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESHTMLViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@property (nonatomic, strong) NSURL *contentURL;
@property (nonatomic, strong) NSString *content;

@end
