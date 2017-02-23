//
//  GameScene.h
//  Saufkopf
//

//  Copyright (c) 2015年 Benjamin Rannow. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class Player;

@interface GameScene : SKScene {
    int lastDropIndex;
}

@property (nonatomic, strong) SKNode *background;
@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) NSMutableSet *recycledObjects;
@property (nonatomic, strong) Player *player;

@end
