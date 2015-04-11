//
//  PlayingCard.h
//  Matchismo
//
//  Created by Chuou Zhang on 5/20/14.
//  Copyright (c) 2014 CZ. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
