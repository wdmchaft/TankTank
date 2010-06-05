//
//  DGWorld.m
//  TankTank
//

#import "DGWorld.h"

@implementation DGWorld

@synthesize tank, tiles;

- (id) init
{
	if (self = [super init]) 
	{
		self.width = 320;
		self.height = 480;
		
		// set background for world
		SPQuad *background = [SPQuad quadWithWidth:480 height:320];
		background.x = 0;
		background.y = 0;
		background.color = 0x000000;
		[self addChild:background];
		
		// create and display player 1 tank
		self.tank = [DGTank tankWithX:100 y:200 speed:DG_BASE_SPEED];
		[self addChild:self.tank];
		
		// create tiles for world
		// TODO take array (from plist) and turn into mutable array
		self.tiles = [[NSMutableArray alloc] initWithCapacity:DG_TILES_TOTAL];
		int currentX = 0;
		int currentY = 0;
		for (int i = 0; i < DG_TILES_HIGH; i++) 
		{
			for (int j = 0; j < DG_TILES_WIDE; j++)
			{
				DGTile* newTile;
				newTile = [[DGTile alloc] initWithX:currentX y:currentY tileType:DG_TILE_WALL];
				NSLog(@"%@", newTile);
				[self addChild:newTile];
				[self.tiles addObject:newTile];
				[newTile release];
				currentX += 32;
			}
			currentY += 32;
		}
		
		// world event listeners
		[self addEventListener:@selector(onWorldEnterFrame:) 
					  atObject:self 
					   forType:SP_EVENT_TYPE_ENTER_FRAME];
		
		[self addEventListener:@selector(onWorldTouch:) 
					  atObject:self 
					   forType:SP_EVENT_TYPE_TOUCH];
		
		NSLog(@"World x=%.2f, y=%.2f, width=%.2f, height=%.2f", self.x, self.y, self.width, self.height);
		
	}
	return self;
	
}

- (void) onWorldEnterFrame:(SPEnterFrameEvent*) event 
{
	[self.tank moveBy:(event.passedTime * self.tank.speed)];
}

- (void) onWorldTouch:(SPTouchEvent*) event 
{
	SPTouch *touch = [[event touchesWithTarget:self 
									  andPhase:SPTouchPhaseBegan] anyObject];
    if (touch) 
	{
		BOOL isMoving = FALSE;
		if (touch.tapCount > 1) isMoving = TRUE;
		SPPoint *touchPosition = [touch locationInSpace:self];
		NSLog(@"Touched position (%f, %f)", touchPosition.x, touchPosition.y);
		[self.tank destinationFromTouch:touchPosition willMove:isMoving];
    }	
}

- (void) dealloc
{
	[self removeEventListenersAtObject:self forType:SP_EVENT_TYPE_ENTER_FRAME];
	[self removeEventListenersAtObject:self forType:SP_EVENT_TYPE_TOUCH];
	self.tank = nil;
	self.tiles = nil;
	[tank release];
	[super dealloc];
}

@end
