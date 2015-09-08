//
//  ESAppDelegate.m
//  FastenKalender
//
//  Created by Christoph Wottawa on 28.01.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "ESAppDelegate.h"
#import <Parse/Parse.h>

@implementation ESAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
	if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
		UIColor *purple = [UIColor colorWithRed:122/255.0f green:2/255.0f blue:51/255.0f alpha:1.0f];
		//[[UINavigationBar appearance] setBarTintColor:purple];
		//[[UITabBar appearance] setBarTintColor:purple];
        [self.window setTintColor:purple];
	}
    
    //Set the AudioSessio to Playback, to enable background audio from the WebView
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    BOOL ok;
    NSError *setCategoryError = nil;
    ok = [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    
    if(!ok) {
        NSLog(@"%s setCategoryError = %@", __PRETTY_FUNCTION__, setCategoryError);
    }
    
	
	//Start Parse:
	[Parse setApplicationId:@"JVnm7CPwU4b0h0g15SLOnD6bQsm2q3ZTy8ONqF1O"
				  clientKey:@"CVkXbq6tPmfJm9hzhIRMjp3S77glxmFjnpSJZrJq"];
	
	application.applicationIconBadgeNumber = 0;
    
    UILocalNotification *localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotification) {
        // Set icon badge number to zero
		//application.applicationIconBadgeNumber = 0;
	
		[application cancelLocalNotification:localNotification];
    }
	
    return YES;
}

//receive notifications:
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
	
	UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erinnerung"
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:notification.alertAction
											  otherButtonTitles:nil];
        [alert show];
    }
	
	[application cancelLocalNotification:notification];
	application.applicationIconBadgeNumber = 0;
	
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
