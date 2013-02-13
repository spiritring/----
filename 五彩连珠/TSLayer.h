//
//  TSLayer.h
//  五彩连珠
//
//  Created by TSEnel on 13-2-11.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class ITSSprite;

@interface TSLayer : CCLayer
{    
@public
    ITSSprite* m_Player;
    ITSSprite* m_Mesh;
    ITSSprite* m_BackGround;
    CGPoint m_Velocity;
}
+(id) scene;
+(CGPoint) locationFromTouches:(NSSet*)touches;
+(CGPoint) locationFromTouch:(UITouch*)touch;
@end
