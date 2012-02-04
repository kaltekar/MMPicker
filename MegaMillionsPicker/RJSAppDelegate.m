//
//  RJSAppDelegate.m
//  LotteryPicker
//
//  Created by Stoner, Reed on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RJSAppDelegate.h"
#import "SCLotteryEngine.h"
#import "SCParseLottoryResults.h"

@implementation RJSAppDelegate

@synthesize window = _window;
@synthesize engine = _engine;
@synthesize parser = _parser;

@synthesize ball1 = _ball1;
@synthesize ball2 = _ball2;
@synthesize ball3 = _ball3;
@synthesize ball4 = _ball4;
@synthesize ball5 = _ball5;
@synthesize megaBall = _megaBall;

- (void) parse {
    [self.parser parseResults];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parse) name:@"SCDidFinishRetrievingLottoData" object:nil];
    _engine = [[SCLotteryEngine alloc] init];
    _parser = [[SCParseLottoryResults alloc] init];
    [self.parser retrieveLottoryResults];
    //[parser parseResults];
    
 


}

- (IBAction)getPicks:(id)sender {
    
    NSArray *array = [self.engine picks];
    
    [self.ball1 setStringValue:[NSString stringWithFormat:@"%@",[array objectAtIndex:0]]];
    [self.ball2 setStringValue:[NSString stringWithFormat:@"%@",[array objectAtIndex:1]]]; 
    [self.ball3 setStringValue:[NSString stringWithFormat:@"%@",[array objectAtIndex:2]]];
    [self.ball4 setStringValue:[NSString stringWithFormat:@"%@",[array objectAtIndex:3]]];
    [self.ball5 setStringValue:[NSString stringWithFormat:@"%@",[array objectAtIndex:4]]];
    
    [self.megaBall setStringValue:[NSString stringWithFormat:@"%@",[array objectAtIndex:5]]];
    
}
@end
