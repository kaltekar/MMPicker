//
//  RJSAppDelegate.h
//  LotteryPicker
//
//  Created by Stoner, Reed on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SCLotteryEngine;
@class SCParseLottoryResults;

@interface RJSAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) SCLotteryEngine *engine;
@property (nonatomic, strong) SCParseLottoryResults *parser;

@property (weak) IBOutlet NSTextField *ball1;
@property (weak) IBOutlet NSTextField *ball2;
@property (weak) IBOutlet NSTextField *ball3;
@property (weak) IBOutlet NSTextField *ball4;
@property (weak) IBOutlet NSTextField *ball5;
@property (weak) IBOutlet NSTextField *megaBall;

- (IBAction)getPicks:(id)sender;

@end
