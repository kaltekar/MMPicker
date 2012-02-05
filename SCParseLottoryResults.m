//
//  SCParseLottoryResults.m
//  MegaMillionsPicker
//
//  Created by Reed Stoner on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SCParseLottoryResults.h"
#import "SCMMResult.h"
@implementation SCParseLottoryResults
/*
@synthesize url = _url;
@synthesize file = _file;
 */
@synthesize results = _results;
@synthesize parsedResultsArray = _parsedResultsArray;

- (void) retrieveLottoryResults {
    
    // Data from http://www.state.nj.us/lottery/data/big.dat

    NSString *file = [[NSBundle mainBundle] pathForResource:@"big" ofType:@"dat"];
//    NSLog(@"%@", _file);
    NSURL *url = [NSURL fileURLWithPath:file];
    
//    NSURL *url = [NSURL URLWithString:@"http://www.state.nj.us/lottery/data/big.dat"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    __unused NSURLConnection *fetchConn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];

}

- (void) parseResults {

    NSArray *array = [[self.results componentsSeparatedByString:@"\n"] mutableCopy];
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    for (NSString *resultStr in array) {
        SCMMResult *result = [[SCMMResult alloc] initWithFormatedString:resultStr];
        if (result) {
            [results addObject:result];
        } else {
            NSLog(@"String, %@, not properly formated.", resultStr);
        }
    }
        NSLog(@"Parse did finish Parser");

    _parsedResultsArray = results;
    
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"SCParseLotteryResultsParseDiDFinish"  object:nil]];
    
}


#pragma mark -
#pragma mark NSURLConnection Delegate Methods

// Called each time a chunk of data arrives
- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {

    if (!incomingData) {
        incomingData = [[NSMutableData alloc] init];
    }
    
    [incomingData appendData:data];
}


//Called when the last chucnk has been procsseded

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    
    self.results =[[NSString alloc] initWithData:incomingData encoding:NSASCIIStringEncoding];
    
    incomingData = nil;

    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"SCParseLotteryResultsDidFinishRetrievingLottoData" object:nil]];
}

// Called if the fetchfails
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"connection failed: %@", [error localizedDescription]);
    incomingData = nil;
}

@end
