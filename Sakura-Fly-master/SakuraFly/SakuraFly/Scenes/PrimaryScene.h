//
//  MainScene.h
//  SakuraFly
//
//  Created by Chenglin on 15-10-1.
//  Copyright (c) 2015年 Chenglin. All rights reserved.
//

#import "BaseScene.h"

@interface PrimaryScene : BaseScene

@property (nonatomic, assign) BOOL isGameStart;

- (void)update:(NSTimeInterval)currentTime;

-(void)updateSource;

- (void)addWall;

- (void)addHeroNode;

- (void)addCeiling;

- (SKAction *)getFlyAction;

- (void)gameOver;

- (void) didEndContact:(SKPhysicsContact *)contact;

- (UIViewController *)currentViewController;

@end
