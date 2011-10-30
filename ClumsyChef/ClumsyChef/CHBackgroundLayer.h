//
//  CHBackgroundLayer.h
//  ClumsyChef
//
//  Created by Tong on 24/10/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

/**
 Background layer with parallax effect
 */
@interface CHBackgroundLayer : CCNode {
    CCSprite *background1;
    CCSprite *background2;
    CCSprite *sideBuilding;
    
    float speed1;
    float speed2;
    
    CGSize screenSize;

}

@end
