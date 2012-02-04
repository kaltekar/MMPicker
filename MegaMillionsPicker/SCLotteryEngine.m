//
//  SCLotteryEngine.m
//  MegaMillionsPicker
//
//  Created by Reed Stoner on 9/4/09.
//  Copyright 2009 Simple Chaos.net. All rights reserved.
//

#import "SCLotteryEngine.h"

#define NUMBERS 56
#define MEGABALLS 48

@implementation SCLotteryEngine 

@synthesize numbers = _numbers;
@synthesize megaBalls = _megaBalls;



- (void) reset {
    _numbers = nil;
    _megaBalls = nil;
    
    _numbers = [[NSMutableArray alloc] initWithCapacity:NUMBERS];
    _megaBalls = [[NSMutableArray alloc] initWithCapacity:MEGABALLS];
    for (NSUInteger i = 1; i <= NUMBERS; i++) {
        [self.numbers addObject:[NSNumber numberWithInteger:i]];
    }
    for (NSUInteger i = 1; i <= MEGABALLS; i++) {
        [self.megaBalls addObject:[NSNumber numberWithInteger:i]];
    }        
}

-(NSArray *)picks {
    
    [self reset];
    
	NSMutableArray *picks = [[NSArray array] mutableCopy];
    for (int i = 0; i < 5; i++) {
        NSUInteger index = arc4random() % [self.numbers count];
        [picks addObject:[self.numbers objectAtIndex:index]];
        [self.numbers removeObjectAtIndex:index];
    }
    
    [picks sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"integerValue" ascending:YES], nil]];
    
    [picks addObject:[self.megaBalls objectAtIndex:arc4random() % MEGABALLS]];
    
 	return picks;
}

@end
