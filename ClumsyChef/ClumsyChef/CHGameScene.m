//
//  CHGameScene.m
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import "CHGameScene.h"
#import "CHGameLayer.h"
#import "CHGameLibrary.h"
#import "CHGameWinLayer.h"
#import "CHGameLoseLayer.h"
#import "CHPauseLayer.h"
#import "CHPlayerInfo.h"
#import "SimpleAudioEngine.h"


@implementation CHGameScene
{
	CHGameLayer		*_gameLayer;
    NSUInteger		_levelIndex;
	NSUInteger		_moneyAmount;
}

#pragma mark - 
#pragma mark Private

- (void)showModalOverlay:(CHModalLayer *)modalLayer
{
	_gameLayer.isPaused = YES;
	_gameLayer.visible = NO;
	[modalLayer showAsModalLayerInNode:self];
}

- (void)prepareToDismissModalOverlay
{
	_gameLayer.isPaused = NO;
	_gameLayer.visible = YES;
}

#pragma mark - 
#pragma mark Constructor and destructor

- (id)initWithLevelIndex:(NSUInteger)levelIndex
{
	if (self = [super init])
	{
		_levelIndex = levelIndex;
		_moneyAmount = 0;
		_gameLayer = [CHGameLayer nodeWithLevelIndex:levelIndex];
		_gameLayer.moneyAmount = _moneyAmount;
        [self addChild:_gameLayer];
	}
	return self;
}

+ (id)nodeWithLevelIndex:(NSUInteger)levelIndex
{
	return [[[self alloc] initWithLevelIndex:levelIndex] autorelease];
}

+ (id)node
{
	NSAssert(NO, @"+node no longer used, use +nodeWithLevelIndex");
	return nil;
}

- (void)dealloc
{
	[super dealloc];
}

#pragma mark - 
#pragma mark Game Win/Game Lose

- (void)showWin:(NSInteger)score
{
	[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];

	// Update the number of cleared levels of CHPlayerInfo
	CHPlayerInfo *info = [CHPlayerInfo sharedPlayerInfo];
	if (info.numClearedLevels < _levelIndex + 1)
	{
		info.numClearedLevels = _levelIndex + 1;
	}
	
	_moneyAmount = score;
	[self showModalOverlay:[CHGameWinLayer nodeWithLevelIndex:_levelIndex 
														   moneyAmount:score]];
}

- (void)showGameOver
{
	[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    [self showModalOverlay:[CHGameLoseLayer node]];
}

#pragma mark -
#pragma mark Pause

- (void)pauseGame
{
	[[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
	[self showModalOverlay:[CHPauseLayer node]];
}

- (void)resumeGame
{
    [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
	[self prepareToDismissModalOverlay];
}

- (void)restartLevel
{
	[_gameLayer resetForLevelIndex:_levelIndex];
	_gameLayer.moneyAmount = _moneyAmount;
	[self prepareToDismissModalOverlay];
}

- (BOOL)hasNextLevel
{
	NSUInteger numLevels = [[CHGameLibrary sharedGameLibrary] numberOfLevels];
	return (_levelIndex + 1 < numLevels);
}

- (void)loadNextLevel
{
	NSAssert([self hasNextLevel], @"No next level");
	_levelIndex++;
	[_gameLayer resetForLevelIndex:_levelIndex];
	_gameLayer.moneyAmount = _moneyAmount;
	[self prepareToDismissModalOverlay];
}

- (void)quitGame
{
	[[CCDirector sharedDirector] popSceneWithTransition:[CCTransitionFade class] 
											   duration:0.6f];
}

@end
