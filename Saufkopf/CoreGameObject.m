//
//  CoreGameObject.m
//  Saufkopf
//
//  Created by Benjamin Rannow on 2015/02/24.
//  Copyright (c) 2015年 Benjamin Rannow. All rights reserved.
//

#import "CoreGameObject.h"

@implementation CoreGameObject

- (id) init
{
    self = [super init];
    if(self)
    {
        self.scene.scaleMode = SKSceneScaleModeAspectFit;
        
        self.zPosition = 2.0f;
       
        // 2
        self.physicsBody.dynamic = YES;
        // 3
        self.physicsBody.allowsRotation = NO;
        // 4
        self.physicsBody.restitution = 1.0f;
        self.physicsBody.friction = 0.0f;
        self.physicsBody.angularDamping = 0.0f;
        self.physicsBody.linearDamping = 0.0f;
        
    }
    return self;
}

@end
