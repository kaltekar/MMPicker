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
    
    NSMutableSet *set = [[NSMutableSet alloc] initWithCapacity:NUMBERS];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:MEGABALLS];
    for (NSUInteger i = 1; i <= NUMBERS; i++) {
        [set addObject:[NSNumber numberWithInteger:i]];
    }
    for (NSUInteger i = 1; i <= MEGABALLS; i++) {
        [array addObject:[NSNumber numberWithInteger:i]];
    }        
    _numbers = [NSMutableSet setWithSet:set];
    _megaBalls = [NSMutableArray arrayWithArray:array];

}

-(NSArray *)picks {
    
    [self reset];
    
	NSMutableArray *array = [[NSArray array] mutableCopy];
    for (int i = 0; i < 5; i++) {

        __block BOOL picked = NO;
        while (!picked) {
            NSUInteger value = arc4random() % NUMBERS;
            //NSLog(@"Value: %lu", value);
            [self.numbers enumerateObjectsUsingBlock:^(id obj, BOOL *stop){
                if([obj integerValue]==value){
                    [array addObject:obj];
                    [self.numbers removeObject:obj];
                    picked=YES;
                    *stop=YES;
                } 
            } ];
        }
    }
    [array sortUsingDescriptors:[NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"integerValue" ascending:YES], nil]];
    
    [array addObject:[self.megaBalls objectAtIndex:arc4random() % MEGABALLS]];
    NSLog(@"Count: %lu", [array count]);
 	return array;
}

@end
