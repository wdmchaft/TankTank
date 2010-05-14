//
//  DGGame.h
//  AppScaffold
//
//  Created by Nathan Koch on 4.25.10
//  Copyright 2010 Dark Green Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sparrow.h"
#import "DGWorld.h"


@interface DGGame : SPStage
{
	SPSprite* contents;
	DGWorld* world;
	SPButton* fireButton;
}

@property (nonatomic, retain) SPSprite* contents;
@property (nonatomic, retain) DGWorld* world;
@property (nonatomic, retain) SPButton* fireButton;

@end