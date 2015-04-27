//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Chuou Zhang on 5/6/14.
//  Copyright (c) 2014 CZ. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (strong, nonatomic) IBOutlet UIButton *restartButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *gameModeSegControl;
@property (nonatomic) NSInteger gameMode;
@end

@implementation CardGameViewController

// init
- (void)initSegControls {
    if (!_gameModeSegControl) {
        _gameModeSegControl = [[UISegmentedControl alloc] init];
    }
}

- (void)viewDidLoad
{
    // set gameMode
    // self.gameMode=self.gameModeSegControl.selectedSegmentIndex;
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}
- (IBAction)touchSegControl:(id)sender
{
    self.game.gameMode = self.gameModeSegControl.selectedSegmentIndex;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSLog(@"%ld", self.gameMode);
    //[self setEnabledGameModeSegControl:NO];
    [self.gameModeSegControl setEnabled:NO];
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)touchRestartButton:(UIButton *)sender {
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    [self.gameModeSegControl setEnabled:YES];
    [self updateUI];
}

- (void)updateUI
{
    // update buttons
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLable.text = [NSString stringWithFormat:@"Score: %li", (long)self.game.score];
    }
    
    // update SegControls
    //[self.gameModeSegControl setEnabled:NO];
}


- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
