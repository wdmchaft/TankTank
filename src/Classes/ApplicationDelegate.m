//
//  AppScaffoldAppDelegate.m
//  AppScaffold
//
//  Created by Daniel Sperl on 14.01.10.
//  Copyright Incognitek 2010. All rights reserved.
//

#import "ApplicationDelegate.h"
#import "Game.h" 

@implementation ApplicationDelegate

@synthesize window;
@synthesize sparrowView;

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{    
    SP_CREATE_POOL(pool);    
    
    Game *game = [[Game alloc] initWithWidth:320 height:480];        
    sparrowView.stage = game;
    [sparrowView start];
    [window makeKeyAndVisible];
    [game release];    
    
    SP_RELEASE_POOL(pool);
}

- (void)applicationWillResignActive:(UIApplication *)application 
{
    sparrowView.frameRate = 5;
}

- (void)applicationDidBecomeActive:(UIApplication *)application 
{
    sparrowView.frameRate = 30;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [SPPoint purgePool];
    [SPRectangle purgePool];
    [SPMatrix purgePool];    
}

- (void)dealloc 
{
    [window release];
    [super dealloc];
}

@end
