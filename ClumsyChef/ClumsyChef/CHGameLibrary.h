//
//  CHGameLibrary.h
//  ClumsyChef
//
//  Created by Tong on 20/10/11.
//  Copyright (c) 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>



/*-----------------------------------------------------------------
 Recipe Item
 -----------------------------------------------------------------*/

@interface CHRecipeItemInfo : NSObject 

@property(nonatomic, readonly, retain) NSString *itemName;
@property(nonatomic, readonly, retain) NSString *spriteFilename;

@end

/*-----------------------------------------------------------------
 Harmful item info
 -----------------------------------------------------------------*/

@interface CHHarmfulItemInfo : NSObject 

@property(nonatomic, readonly, retain) NSString *itemName;
@property(nonatomic, readonly, retain) NSString *spriteFilename;

@end

/*-----------------------------------------------------------------
 Level info
 -----------------------------------------------------------------*/

@interface CHLevelInfo : NSObject 

// Background information
@property(nonatomic, readonly, retain) NSString *levelName;
@property(nonatomic, readonly, retain) NSString *previewImage;
@property(nonatomic, readonly, retain) NSString *finishImage;
@property(nonatomic, readonly, assign) NSUInteger worldHeight;
@property(nonatomic, readonly, retain) NSString *backgroundSideBuildingImage;
@property(nonatomic, readonly, retain) NSString *backgroundBackImage;

@property(nonatomic, readonly, retain) NSArray *recipeItems;

// TODO: More

@end


/**
 * CHGameLibrary
 * A centralized place to look for:
 *    - stage info
 *    - receipt item info
 */
@interface CHGameLibrary : NSObject


+ (CHGameLibrary *)sharedGameLibrary;		// Singleton object

// Obtain game item info
- (CHRecipeItemInfo *)recipeItemInfoWithName:(NSString *)itemName;

- (CHHarmfulItemInfo *)randomHarmfulItem;

//- (CHHarmfulItemInfo *)harmfulItemInfoWithID:(NSString *)itemName;

// Obtain stage info
- (NSUInteger)numberOfLevels;
- (CHLevelInfo *)levelInfoAtIndex:(NSUInteger)index;

+ (void)test;

@end


