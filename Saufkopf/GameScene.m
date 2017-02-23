//
//  GameScene.m
//  Saufkopf
//
//  Created by Benjamin Rannow on 2015/02/24.
//  Copyright (c) 2015年 Benjamin Rannow. All rights reserved.
//

#import "GameScene.h"
#import "Bottle.h"
#import "Player.h"

#include <stdlib.h>

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation GameScene

-(id) initWithSize:(CGSize)size
{  
    self = [super initWithSize:size];
    if(self)
    {
        self.scaleMode = SKSceneScaleModeAspectFill;
        
        self.background = [self backgroundNode];
        [self addChild:self.background];
        
        self.player = [[Player alloc] init];
        [self.player setScale:size.width / 1024];
        
        [self addChild:self.player];
        
        self.player.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame) + 40);
        
        self.physicsWorld.gravity = CGVectorMake(0.0f, -2.0f);
    }
    return self;
}

- (CGPoint)convertPoint:(CGPoint)point
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return CGPointMake(32 + point.x*2, 64 + point.y*2);
    } else {
        return point;
    }
}

- (SKNode*) backgroundNode
{
    SKTexture *texture = [SKTexture textureWithImageNamed:@"BG"];
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:texture size:self.frame.size];
    node.zPosition = 1.0f;
    node.anchorPoint = CGPointMake(0.0f, 0.0f);
    return node;
}

-(void)didMoveToView:(SKView *)view
{
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(addBottle)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)addBottle {
    if([self.background.children count] < 7) {
        Bottle *bottle = [[Bottle alloc] init];
        [bottle setScale:self.frame.size.width / 1024];
        bottle.name = @"bottle";
        [self.background addChild:bottle];
        [self placeBottleInScene:bottle];
        NSLog(@"add bottle");
    }
}

- (void) placeBottleInScene:(Bottle*)bottle
{
    const float dropMatrix[7] = {0.15f, 0.27f, 0.35f, 0.5f, 0.6f, 0.75f, 0.9f};
    int index = [self newDropIndexWithRange:7];

    float xDrop = self.frame.size.width * dropMatrix[index];
    [bottle setPosition:CGPointMake(xDrop, self.frame.size.height+20)];
    
    
     float dx = ((float)rand() / RAND_MAX) * 5;
     float dy = ((float)rand() / RAND_MAX) * 20;

    CGVector impulse = CGVectorMake(-dx,-dy);
     bottle.physicsBody.velocity = CGVectorMake(0, 0);
     [bottle.physicsBody applyImpulse:impulse];
}

- (int) newDropIndexWithRange:(int)range {
    int dropIndex = arc4random_uniform(range);
    if(dropIndex == lastDropIndex) {
        dropIndex++;
        if(dropIndex == range) {
            dropIndex = 0;
        }
    }
    lastDropIndex = dropIndex;
    return dropIndex;
}

- (void)didEvaluateActions
{
    if(self.player.moveRight)
    {
        self.player.physicsBody.velocity=CGVectorMake(120, 0);
    } else if(self.player.moveLeft)
    {
        self.player.physicsBody.velocity=CGVectorMake(-120, 0);
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = (UITouch *)[touches anyObject];
    CGPoint point = [touch locationInNode:self];
    
    self.player.moveLeft = NO;
    self.player.moveRight = NO;
    
    if(self.player.position.x >= point.x)
    {
        self.player.moveLeft = YES;
    }
    else if(self.player.position.x < point.x)
    {
        self.player.moveRight = YES;
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.player.moveLeft = NO;
    self.player.moveRight = NO;
    self.player.physicsBody.velocity = CGVectorMake(0, 0);
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.player.moveLeft = NO;
    self.player.moveRight = NO;
    self.player.physicsBody.velocity = CGVectorMake(0, 0);
}

-(void)update:(CFTimeInterval)currentTime {
    
    for (CoreGameObject *object in self.background.children) {
        if([object isKindOfClass:[Bottle class]])
        {
            Bottle *b = (Bottle*)object;
            if(b.position.y < -50) {
                [self placeBottleInScene:b];
            }
        }
    }
}

- (void)didChangeSize:(CGSize)oldSize
{
    for (SKNode *node in self.children)
    {
        CGPoint newPosition;
        newPosition.x = node.position.x / oldSize.width * self.frame.size.width;
        newPosition.y = node.position.y / oldSize.height * self.frame.size.height;
        node.position = newPosition;
    }
}

@end
