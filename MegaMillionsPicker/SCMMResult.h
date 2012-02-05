//
//  SCMMResult.h
//  MegaMillionsPicker
//
//  Created by Stoner, Reed on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCMMResult : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSArray *numbers;
@property (nonatomic, strong) NSNumber *megaball;
@property (nonatomic, strong) NSString *payout;

- (id)initWithFormatedString:(NSString *)string;

@end
