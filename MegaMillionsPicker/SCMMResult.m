//
//  SCMMResult.m
//  MegaMillionsPicker
//
//  Created by Stoner, Reed on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/* 
     (0)        Year – formatted as YYYY
     (1)        Month – formatted as MM
     (2)        Day – formatted as DD
     (3)        Day of Week – formatted as Tuesday and Friday
     (4 - 8)    Ball 1, 2, 3, 4, 5 – as an integer 
     (9)       MegaBall – as an integer
     (10)       Prize Payout – when present, formatted as a decimal value
     (11)       NULL
     (12)       Unknown
     (13)       Date – formatted as YYYYMMDD
     (14)       Unknown
 */

#import "SCMMResult.h"

@implementation SCMMResult

@synthesize date = _date;
@synthesize numbers = _numbers;
@synthesize megaball = _megaball;
@synthesize payout = _payout;


- (id)initWithFormatedString:(NSString *)string {
    self = [super init];
    if (self) {
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [f setFormatterBehavior:NSNumberFormatterDecimalStyle];
        
        NSArray *array = [string componentsSeparatedByString:@"%"];
        if ([array count] < 12) {
            NSLog(@"Formatted string did not contain the proper number of items");
            return nil;
        }
        
        NSNumber *year = [f numberFromString:[array objectAtIndex:0]];
        NSNumber *month = [f numberFromString:[array objectAtIndex:1]];
        NSNumber *day = [f numberFromString:[array objectAtIndex:2]];
        
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setYear:[year integerValue]];
        [components setMonth:[month integerValue]];
        [components setDay:[day integerValue]]; 
        NSCalendar *gregorian = [[NSCalendar alloc]
                                 initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *d = [gregorian dateFromComponents:components];
        _date = d;
        
        NSNumber *ball1 = [f numberFromString:[array objectAtIndex:4]];
        NSNumber *ball2 = [f numberFromString:[array objectAtIndex:5]];
        NSNumber *ball3 = [f numberFromString:[array objectAtIndex:6]];
        NSNumber *ball4 = [f numberFromString:[array objectAtIndex:7]];
        NSNumber *ball5 = [f numberFromString:[array objectAtIndex:8]];

        NSArray *numArray = [NSArray arrayWithObjects:ball1, ball2, ball3, ball4, ball5, nil];
        _numbers = numArray;
        
        NSNumber *mb = [f numberFromString:[array objectAtIndex:9]];
        _megaball = mb;
        
        NSString *po = [array objectAtIndex:10];
        _payout = po;
    }
    return self;
}

- (NSString *) description {
    
    NSString *ball1 = [NSString stringWithFormat:@"%@", [self.numbers objectAtIndex:0]];
    NSString *ball2 = [NSString stringWithFormat:@"%@", [self.numbers objectAtIndex:1]];
    NSString *ball3 = [NSString stringWithFormat:@"%@", [self.numbers objectAtIndex:2]];
    NSString *ball4 = [NSString stringWithFormat:@"%@", [self.numbers objectAtIndex:3]];
    NSString *ball5 = [NSString stringWithFormat:@"%@", [self.numbers objectAtIndex:4]];
    
    NSString *string = [NSString stringWithFormat:@"Drawing date: %@ Numbers %@, %@, %@, %@, %@ Megaball %d Payout: %@", self.date, ball1, ball2, ball3, ball4, ball5, [self.megaball intValue], self.payout];
    return string;
}

@end
