//
//  SCParseLottoryResults.m
//  MegaMillionsPicker
//
//  Created by Reed Stoner on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SCParseLottoryResults.h"

@implementation SCParseLottoryResults

@synthesize url = _url;
@synthesize file = _file;
@synthesize results = _results;
@synthesize array = _array;
- (id)init {
    self = [super init];
    if (self) {
                 
    }
    return self;
}

- (void) retrieveLottoryResults {
    _file = [[NSBundle mainBundle] pathForResource:@"testdata" ofType:@"csv"];
    NSLog(@"%@", _file);
    _url = [NSURL URLWithString:self.file];
    NSLog(@"%@", _url);
    _results = [NSString stringWithContentsOfFile:self.file encoding:NSASCIIStringEncoding error:nil];
    NSLog(@"%@", _results);
}

- (void) parseResults {

    NSMutableArray *array = [[self.results componentsSeparatedByString:@"\n"] mutableCopy];
    NSLog(@"%@", array);
    
}

@end
