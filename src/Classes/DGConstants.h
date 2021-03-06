//
//  DGConstants.h
//  TankTank
//
//  Created by Nathan Koch on 4/19/10.
//  Copyright 2010 Dark Green Developmet. All rights reserved.
//

#define DG_WORLD_BLUE @"BlueWorld"

#define DG_TEXTURE_TANK_IDLE @"tank_idle"
#define DG_TEXTURE_TANK_MOVE_01 @"tank_move_01"
#define DG_TEXTURE_TANK_MOVE_02 @"tank_move_02"
#define DG_TEXTURE_BLUE_WALL @"blue_wall"
#define DG_TEXTURE_GREEN_WALL @"green_wall"

#define DG_EVENT_TYPE_WORLD_TOUCHED @"worldTouched"

#define DG_SINGLE_TILE_WIDTH 32
#define DG_SINGLE_TILE_HEIGHT 32

#define DG_TILES_WIDE 15
#define DG_TILES_HIGH 10
#define DG_TILES_TOTAL (DG_TILES_WIDE * DG_TILES_HIGH)

#define DG_TILE_EMPTY 0
#define DG_TILE_BLUE_WALL 1
#define DG_TILE_GREEN_WALL 2

#define DG_TANK_SCALING 0.8f
#define DG_TANK_ROTATION_SPEED 1.0f
#define DG_TANK_BASE_SPEED 1.5f