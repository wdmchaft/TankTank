//
//  Game.h
//  AppScaffold
//
//  Created by Daniel Sperl on 14.01.10.
//  Copyright 2010 Incognitek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sparrow.h" 
#import "Tank.h"

@interface Game : SPStage
{
	SPSprite *sprite;
	Tank *tank;
}

@property (nonatomic, retain) SPSprite *sprite;
@property (nonatomic, retain) Tank *tank;

@end