//
//  CHCoinObject.m
//  ClumsyChef
//
//  Created by Tong on 2/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHCoinObject.h"
#import "CHGameScene.h"

@implementation CHCoinObject
{
}

+ (id)node
{
	return [[[self alloc] initWithFile:@"gameObject-testIcon.png"] autorelease];
}

- (id)initWithFile:(NSString *)filename
{
	if (self = [super initWithFile:filename])
	{
	}
	return self;
}

+ (void)preloadResources
{
	// TODO
}

+ (void)unloadResources
{
	// TODO
}

- (void)didCollideWithChef
{
}
@end