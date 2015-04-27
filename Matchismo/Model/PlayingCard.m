//
//  PlayingCard.m
//  Matchismo
//
//  Created by Chuou Zhang on 5/20/14.
//  Copyright (c) 2014 CZ. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 2) {
        PlayingCard *firstSelectedCard = [otherCards objectAtIndex:0];
        PlayingCard *secondSelectedCard = [otherCards objectAtIndex:1];
        if (self.rank == firstSelectedCard.rank && self.rank == secondSelectedCard.rank) {
            score = 12;
        }
        if ([self.suit isEqualToString: firstSelectedCard.suit] && [self.suit isEqualToString:secondSelectedCard.suit]) {
            score = 3;
        }
        if (!score && (self.rank == firstSelectedCard.rank || self.rank == secondSelectedCard.rank || firstSelectedCard.rank == secondSelectedCard.rank)) {
            score = 4;
        }
        if (!score && ([self.suit isEqualToString: firstSelectedCard.suit] || [self.suit isEqualToString:secondSelectedCard.suit] || [firstSelectedCard.suit isEqualToString:secondSelectedCard.suit])) {
            score = 1;
        }
        
    }
    
    if ([otherCards count]==1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 8;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 2;
        }
    }
    
    return score;
}

+(NSArray *)validSuits
{
    return @[@"♣︎",@"♠︎",@"♥︎",@"♦︎"];
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit=_suit;
- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
