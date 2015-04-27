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
@property (nonatomic, strong) NSMutableArray *chosenCards;
@property (nonatomic, strong) NSMutableString *labelString;
@end

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

@implementation CardMatchingGame

- (NSMutableArray *)chosenCards
{
    if(!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
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
    [self.chosenCards removeAllObjects];
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index]:nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen=NO;
            [self.chosenCards removeObject:card];
        } else {
            int matchScore = 0;
            if (self.gameMode == 0) { // 2-card matching
                if ([self.chosenCards count]) {
                    matchScore = [card match:self.chosenCards];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        for (Card *chosenCard in self.chosenCards) {
                            chosenCard.matched = YES;
                        }
                        [self.chosenCards removeAllObjects];
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        for (Card *chosenCard in self.chosenCards) {
                            chosenCard.chosen = NO;
                        }
                        [self.chosenCards removeAllObjects];
                        [self.chosenCards addObject:card];
                    }
                    
                } else {
                    [self.chosenCards addObject:card];
                }
            } else { // 3-card matching
                if ([self.chosenCards count] < 2) {
                    [self.chosenCards addObject:card];
                } else {
                    matchScore = [card match:self.chosenCards];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        for (Card *chosenCard in self.chosenCards) {
                            chosenCard.matched = YES;
                        }
                        [self.chosenCards removeAllObjects];
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        for (Card *chosenCard in self.chosenCards) {
                            chosenCard.chosen = NO;
                        }
                        [self.chosenCards removeAllObjects];
                        [self.chosenCards addObject:card];
                    }
                }
            }
            
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    
}






@end
