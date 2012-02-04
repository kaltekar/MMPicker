//
//  SCParseLottoryResults.h
//  MegaMillionsPicker
//
//  Created by Reed Stoner on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCParseLottoryResults : NSObject

@property (strong) NSURL *url;
@property (strong) NSString *file;
@property (strong) NSString *results;
@property (strong) NSArray *array;

- (void) parseResults;
- (void) retrieveLottoryResults;

@end
