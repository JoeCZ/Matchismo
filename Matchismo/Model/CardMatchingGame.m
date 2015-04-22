//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Chuou Zhang on 5/30/14.
//  Copyright (c) 2014 CZ. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) NSMutableSet *chosenCards;
@end

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

@implementation CardMatchingGame

- (NSMutableSet *)chosenCards
{
    if(!_chosenCards) _chosenCards = [[NSMutableSet alloc] init];
    return _chosenCards;
}

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if(self){
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index]:nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index gameMode:(NSInteger)num
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen=NO;
        } else {
            NSLog(@"%li, %lu",(long)num, (unsigned long)[self.chosenCards count]);
            if (num+1==[self.chosenCards count]) {
                int matchScore = [card match:self.chosenCards];
                NSLog(@"The score is %d", matchScore);
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    for (Card *card in self.chosenCards) {
                        card.matched=YES;
                    }
                    card.matched = YES;
                } else {
                    self.score -= MISMATCH_PENALTY;
                    for (Card *card in self.chosenCards) {
                        card.chosen=NO;
                    }
                }
                [self.chosenCards removeAllObjects];
            }
            if(!card.isMatched)[self.chosenCards addObject:self.cards[index]];
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    
}
- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen=NO;
            [self.chosenCards removeObject:card];
        } else {
            for (Card *otherCard in self.cards){
                if(otherCard.isChosen && !otherCard.isMatched){
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    
}

@end
