//
//  Bottle.m
//  Saufkopf
//
//  Created by Benjamin Rannow on 2015/02/24.
//  Copyright (c) 2015年 Benjamin Rannow. All rights reserved.
//

#import "Bottle.h"
#import <GLKit/GLKit.h>

#define ROTATE_CONST M_PI/16.0

@implementation Bottle

- (id) init
{
    self = [super init];
    if(self)
    {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Bottle"];
        
        // 1
        self.physicsBody = [SKPhysicsBody bodyWithTexture:sprite.texture size:sprite.texture.size];
        // 2
        self.physicsBody.dynamic = YES;
        // 3
        self.physicsBody.allowsRotation = YES;
        // 4
        self.physicsBody.restitution = 0.2f;
        self.physicsBody.friction = 0.0f;
        self.physicsBody.angularDamping = 0.0f;
        self.physicsBody.linearDamping = 0.0f;
        

        [self addChild:sprite];
        
        SKAction *rotation1 = [SKAction rotateByAngle: ROTATE_CONST duration:.5f];
        SKAction *rotation2 = [SKAction rotateByAngle: -ROTATE_CONST duration:.5f];
        //and just run the action
        [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[rotation1, rotation2, rotation2, rotation1]]]];
    }
    return self;
}

@end
