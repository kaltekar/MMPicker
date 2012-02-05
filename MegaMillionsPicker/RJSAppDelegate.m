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
#import "SCMMResult.h"

@implementation RJSAppDelegate

@synthesize window = _window;
@synthesize engine = _engine;
@synthesize parser = _parser;
@synthesize historicalResultsArray = _historicalResultsArray;

@synthesize ball1 = _ball1;
@synthesize ball2 = _ball2;
@synthesize ball3 = _ball3;
@synthesize ball4 = _ball4;
@synthesize ball5 = _ball5;
@synthesize megaBall = _megaBall;
@synthesize historyLabel = _historyLabel;



- (void) parse {
    [self.parser parseResults];
    [self.historyLabel setStringValue:@"Formatting Historical Data"];
}

- (void) parseDidFinish {
    _historicalResultsArray = self.parser.parsedResultsArray;
    [self.historyLabel setStringValue:@"Historical Data Ready"];
    NSLog(@"Parse did finish App Delegate");
    
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parse) name:@"SCParseLotteryResultsDidFinishRetrievingLottoData" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseDidFinish) name:@"SCParseLotteryResultsParseDiDFinish" object:nil];
    _engine = [[SCLotteryEngine alloc] init];
    _parser = [[SCParseLottoryResults alloc] init];
    [self.parser retrieveLottoryResults];
    [self.historyLabel setStringValue:@"Retrieving Historical Data"];
}

- (void) checkPicks:(NSArray *)picks {
    [self.historyLabel setStringValue:@"trying"];
    NSString *pStr = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@",[picks objectAtIndex:0],[picks objectAtIndex:1],[picks objectAtIndex:2],[picks objectAtIndex:3],[picks objectAtIndex:4], [picks objectAtIndex:5]];
//    NSString *pStr = [NSString stringWithFormat:@"%d,%d,%d,%d,%d",5,21,23,26,37];
//    05%21%23%26%37
    NSLog(@"%@",pStr);
    BOOL  isWinner = NO;
    SCMMResult *winner;
    for (SCMMResult *result in self.historicalResultsArray) {
        NSArray *array = result.numbers;
        NSString *hStr = [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@",[array objectAtIndex:0],[array objectAtIndex:1],[array objectAtIndex:2],[array objectAtIndex:3],[array objectAtIndex:4],result.megaball];
        // NSLog(@"%@",hStr);
        if ([hStr isEqualToString:pStr]) {
            isWinner = YES;
            winner = result;
        }
        
    }
    
    if (isWinner) {
        [self.historyLabel setStringValue:[NSString stringWithFormat:@"Won on %@", winner.date]];
        NSLog(@"It's a winner");
    } else {
        [self.historyLabel setStringValue:[NSString stringWithFormat:@"%@", pStr]];
        NSLog(@"Loser");
    }
    
}

- (IBAction)getPicks:(id)sender {
    
    NSArray *array = [self.engine picks];
    
    [self.ball1 setStringValue:[NSString stringWithFormat:@"%@",[array objectAtIndex:0]]];
    [self.ball2 setStringValue:[NSString stringWithFormat:@"%@",[array objectAtIndex:1]]]; 
    [self.ball3 setStringValue:[NSString stringWithFormat:@"%@",[array objectAtIndex:2]]];
    [self.ball4 setStringValue:[NSString stringWithFormat:@"%@",[array objectAtIndex:3]]];
    [self.ball5 setStringValue:[NSString stringWithFormat:@"%@",[array objectAtIndex:4]]];
    
    [self.megaBall setStringValue:[NSString stringWithFormat:@"%@",[array objectAtIndex:5]]];
    [self checkPicks:array];
    
}
@end
