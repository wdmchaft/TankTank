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
		
		// get world map from WorldMap.plist
		NSString* path = [[NSBundle mainBundle] pathForResource:@"WorldMap" 
														 ofType:@"plist"];
		// the plist contains a dictionary with an array of arrays (e.g. 2D array) for each level
		NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
		NSMutableArray *tempArray = [tempDict objectForKey:DG_WORLD_BLUE];
		
		// iterate through temp array, adding each row to our tiles array
		NSUInteger rowIndex = 0;
		self.tiles = [[NSMutableArray alloc] initWithCapacity:DG_TILES_HIGH];
		for (NSArray *row in tempArray)
		{
			NSMutableArray *rowArray = [[NSMutableArray alloc] initWithCapacity:DG_TILES_WIDE];
			[self.tiles insertObject:rowArray atIndex:rowIndex];
			 NSLog(@"Row: %@", row);
			 NSUInteger colIndex = 0;
			 for (NSNumber *typeNum in row)
			 {
				 // calculate the x and y pos of the tile from the indexes
				 NSUInteger currentX = colIndex * DG_SINGLE_TILE_WIDTH;
				 NSUInteger currentY = rowIndex * DG_SINGLE_TILE_HEIGHT;
				 
				 // create a new tile of the type defined in the plist 
				 // at the appropriate location and insert in tiles array
				 DGTile *newTile;
				 newTile = [[DGTile alloc] initWithX:currentX y:currentY tileType:[typeNum integerValue]];
				 [self addChild:newTile];
				 [[self.tiles objectAtIndex:rowIndex] insertObject:newTile atIndex:colIndex];
				 [newTile release];
				 colIndex++;
			 }
			 rowIndex++;
			[rowArray release];
		}
		[tempDict release];
		
		// create and display player 1 tank
		self.tank = [DGTank tankWithX:96 y:128 speed:DG_TANK_BASE_SPEED];
		[self addChild:self.tank];
		
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
	[tiles release];
	[super dealloc];
}

@end
