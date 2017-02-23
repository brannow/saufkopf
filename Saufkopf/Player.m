//
//  Player.m
//  Saufkopf
//
//  Created by Benjamin Rannow on 2015/02/26.
//  Copyright (c) 2015年 Benjamin Rannow. All rights reserved.
//

#import "Player.h"

@implementation Player

- (id) init
{
    self = [super init];
    if(self)
    {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Player"];
        
        // 1
        self.physicsBody = [SKPhysicsBody bodyWithTexture:sprite.texture size:sprite.texture.size];
        // 2
        self.physicsBody.dynamic = YES;
        
        self.physicsBody.affectedByGravity = NO;
        
        self.physicsBody.allowsRotation = NO;
        
        self.physicsBody.restitution = 0.0f;
        self.physicsBody.friction = 0.0f;
        self.physicsBody.angularDamping = 0.0f;
        self.physicsBody.linearDamping = 0.0f;
        
        self.physicsBody.mass = 1000;

        [self addChild:sprite];
    }
    return self;
}

@end
