//
//  TSLayer.m
//  五彩连珠
//
//  Created by TSEnel on 13-2-11.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "TSLayer.h"


@implementation TSLayer

+(id) scene
{
    CCScene* scene = [CCScene node];
    CCLayer* layer = [TSLayer node];
    
    [scene addChild:layer];
    return scene;
}

-(id) init
{
    if (self = [super init]) {
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
        
        self.isAccelerometerEnabled = YES;
        self.isTouchEnabled = YES;
        m_Player = [CCSprite spriteWithFile:@"alien.png"];
        [self addChild:m_Player z:0 tag:1];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        float imageHeight = [m_Player texture].contentSize.height;
        m_Player.position = CGPointMake(screenSize.width / 2, imageHeight / 2);
        
    }
    
    return self;
}

-(void) dealloc
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    [super dealloc];
}

+(CGPoint) locationFromTouches:(NSSet*)touches
{
    return [self locationFromTouch:[touches anyObject]];
}

+(CGPoint) locationFromTouch:(UITouch*)touch
{
    CGPoint touchLocation = [touch locationInView: [touch view]];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

//监听首次触发事件 
- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pPoint = [TSLayer locationFromTouches:touches];
    m_Player.position = CGPointMake(pPoint.x, pPoint.y);
}

//触摸事件 - 当手指在屏幕上进行移动
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pPoint = [TSLayer locationFromTouches:touches];
    m_Player.position = CGPointMake(pPoint.x, pPoint.y);
}

//触摸事件 - 当手指从屏幕抬起时调用的方法
-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

//重力感应
-(void) accelerometer:(UIAccelerometer *)accelerometer
        didAccelerate:(UIAcceleration *)acceleration
{
    
    float deceleration = 0.4f;
    float sensitivity = 6.0f;
    float maxVelocity = 100;
    
    // 基于当前加速计的加速度调整速度
    m_Velocity.x = m_Velocity.x * deceleration + acceleration.x * sensitivity;
    // 我们必须在两个方向上都限制主角精灵的最大速度值
    if (m_Velocity.x > maxVelocity)
    {
        m_Velocity.x = maxVelocity;
    }
    else if (m_Velocity.x < -maxVelocity)
    {
        m_Velocity.x = -maxVelocity;
    }
    
    // 基于当前加速计的加速度调整速度
    m_Velocity.y = m_Velocity.y * deceleration + acceleration.y * sensitivity;
    // 我们必须在两个方向上都限制主角精灵的最大速度值
    if (m_Velocity.y > maxVelocity)
    {
        m_Velocity.y = maxVelocity;
    }
    else if (m_Velocity.y < -maxVelocity)
    {
        m_Velocity.y = -maxVelocity;
    }
}

@end
