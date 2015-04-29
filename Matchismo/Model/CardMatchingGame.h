//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Chuou Zhang on 5/30/14.
//  Copyright (c) 2014 CZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readwrite) NSInteger gameMode;
@property (nonatomic, readonly) NSMutableString *description;

@end
