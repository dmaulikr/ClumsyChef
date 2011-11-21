//
//  TestMenuLayer.m
//  ClumsyChef
//
//  Created by Tong on 23/10/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "TestMenuLayer.h"
#import "CHUtilities.h"
// ----------------------------------
// Add the scene/layer header files for each scene you want to test here
#import "CHBackgroundLayer.h"
#import "CHGameLayer.h"
#import "CHGameScene.h"
#import "CHMainMenuLayer.h"
#import "CHGameLibrary.h"
#import "CHHUDLayer.h"
#import "CHSelectLevelLayer.h"
#import "CHPauseLayer.h"
//-----------------------------------



NSInteger const TestBackButtonTag = -9999;

@implementation TestMenuLayer

- (void)runScene:(CCScene *)scene
{
	[scene addChild:[TestMenuLayer backButton]];	// Add back button
	[[CCDirector sharedDirector] pushScene:scene];
}

- (void)runLayer:(CCLayer *)layer
{
	// Wrap it with a scene
	CCScene *scene = [CCScene node];
	[scene addChild:layer];
	[self runScene:scene];
}

- (CCMenuItem *)menuItemWithTitle:(NSString *)title block:(void (^)(id sender))block
{
	// Create the label
	CCLabelBMFont *label = [CCLabelBMFont labelWithString:title fntFile:@"font-testFont.fnt"];
	CCMenuItem *item = [CCMenuItemLabel itemWithLabel:label block:block];
	return item;
}

- (id)init
{
	if (self = [super initWithColor:ccc4Hex(0x80c8ff) fadingTo:ccc4Hex(0x0593ed)])
	{
		// Add the tests menu item here
		//-----------------------------------
		CCMenuItem *itemTestBg = [self menuItemWithTitle:@"Background Layer" block:^(id sender) {
			[self runLayer:[CHBackgroundLayer node]];
		}];

		CCMenuItem *itemTestGameLayer = [self menuItemWithTitle:@"Game Layer" block:^(id sender) {
			[self runLayer:[CHGameLayer node]];
		}];

		CCMenuItem *itemTestMainMenu = [self menuItemWithTitle:@"Main Menu" block:^(id sender) {
			[self runLayer:[CHMainMenuLayer node]];
		}];
		
		CCMenuItem *itemTestGameScene = [self menuItemWithTitle:@"Game Scene" block:^(id sender) {
			[self runScene:[CHGameScene node]];
		}];
        
        CCMenuItem *itemTestHUD = [self menuItemWithTitle:@"HUD Layer" block:^(id sender) {
			[self runLayer:[CHHUDLayer nodeForTesting]];
		}];
        
        CCMenuItem *itemTestPauseLayer = [self menuItemWithTitle:@"Pause Layer" block:^(id sender) {
			[self runLayer:[CHPauseLayer node]];
		}];
		
		CCMenuItem *itemTestSelectLevel = [self menuItemWithTitle:@"Select Level" block:^(id sender) {
			[self runLayer:[CHSelectLevelLayer node]];
		}];
		
		CCMenu *testMenu = [CCMenu menuWithItems:itemTestBg, itemTestGameLayer, 
							itemTestMainMenu, itemTestGameScene, itemTestHUD, 
							itemTestSelectLevel, itemTestPauseLayer, nil];
		
		// ----------------------------------
		
		CCLayer *layer = [CCLayer node];
		
		
		// team logo
		CCSprite *sprite = [CCSprite spriteWithFile:@"testLayer-teamLogo.png"];
		[sprite setPositionSharp:CHGetWinPointTL(CHGetHalfWinWidth(), 120)];
		[layer addChild:sprite];
		
		// Align the menu items
		testMenu.anchorPoint = CGPointZero;
		testMenu.position = CGPointZero;
		
		CGFloat y = sprite.position.y - sprite.contentSize.height + 20;
		for (CCNode *item in testMenu.children)
		{
			[item setPositionSharp:CGPointMake(CHGetHalfWinWidth(), y)];
			y -= item.contentSize.height;
		}
		
		[layer addChild:testMenu];
		
		[self addChild:layer];
		layer.position = ccp(0, -CHGetWinHeight());
		[layer runAction:[CCEaseElasticOut actionWithAction:[CCMoveBy actionWithDuration:2.f position:ccp(0, 480)]]];
	}
	return self;
}

#pragma mark -
#pragma mark public APIs

+ (CCMenu *)backButton
{
	CCMenuItemImage *item = [CCMenuItemImage itemFromNormalImage:@"testLayer-backButton.png" 
												   selectedImage:@"testLayer-backButton-highlighted.png" 
														   block:^(id sender) {
															   [[CCDirector sharedDirector] popScene];
														   }];
	CCMenu *menu = [CCMenu menuWithItems:item, nil];
	[menu setPositionSharp:CHGetWinPointTL(40, 40)];
	menu.tag = TestBackButtonTag;
	
	return menu;
}
@end
