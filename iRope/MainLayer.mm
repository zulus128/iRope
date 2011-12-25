//
//  MainLayer.m
//  iRope
//
//  Created by вадим on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainLayer.h"
#import "Common.h"

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.

@interface MainLayer()

-(void) initPhysics;
-(void) addNewSpriteAtPosition:(CGPoint)p;
//-(void) createResetButton;

@end

@implementation MainLayer

-(id) init {
    
	if( (self=[super init])) {
		
		// enable events
		
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
		self.isTouchEnabled = YES;
		self.isAccelerometerEnabled = YES;
#elif defined(__MAC_OS_X_VERSION_MAX_ALLOWED)
		self.isMouseEnabled = YES;
#endif
//		CGSize s = [CCDirector sharedDirector].winSize;
		
		// init physics
		[self initPhysics];
		
		// create reset button
//		[self createResetButton];
		
		//Set up sprite
		
//#if 1
		// Use batch node. Faster
        
        [[CCSpriteFrameCache sharedSpriteFrameCache]addSpriteFramesWithFile:@"texture.plist"];
        CCSpriteBatchNode* spriteBatch = [CCSpriteBatchNode batchNodeWithFile:@"texture.png"];
        [self addChild:spriteBatch z:0 tag:kTagParentNode];
        
        hodok = [[Hodok alloc] initWithLayer:self];
        
        godir = hStop;
        
//		CCSpriteBatchNode *parent = [CCSpriteBatchNode batchNodeWithFile:@"blocks.png" capacity:100];
//		spriteTexture_ = [parent texture];
//#else
//		// doesn't use batch node. Slower
//		spriteTexture_ = [[CCTextureCache sharedTextureCache] addImage:@"blocks.png"];
//		CCNode *parent = [CCNode node];
//#endif
//		[self addChild:parent z:0 tag:kTagParentNode];
		
		
//		[self addNewSpriteAtPosition:ccp(s.width/2, s.height/2)];
//		
//		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Tap screen" fontName:@"Marker Felt" fontSize:32];
//		[self addChild:label z:0];
//		[label setColor:ccc3(0,0,255)];
//		label.position = ccp( s.width/2, s.height-50);
		
		[self scheduleUpdate];
	}
	return self;
}

-(void) dealloc {
    
	delete ([[Common instance] getWorld]);
//	[Common instance]->world = NULL;
    [[Common instance] setWorld:NULL];
	
	delete m_debugDraw;
	m_debugDraw = NULL;
	
	[super dealloc];
}	

-(void) initPhysics {
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	b2Vec2 gravity;
	gravity.Set(0.0f, -10.0f);
	[Common instance].world = new b2World(gravity);
	
	
	// Do we want to let bodies sleep?
	[[Common instance] getWorld]->SetAllowSleeping(true);
	
	[[Common instance] getWorld]->SetContinuousPhysics(true);
	
	m_debugDraw = new GLESDebugDraw( PTM_RATIO );
	[[Common instance] getWorld]->SetDebugDraw(m_debugDraw);
	
	uint32 flags = 0;
	flags += b2Draw::e_shapeBit;
	//		flags += b2Draw::e_jointBit;
	//		flags += b2Draw::e_aabbBit;
	//		flags += b2Draw::e_pairBit;
	//		flags += b2Draw::e_centerOfMassBit;
	m_debugDraw->SetFlags(flags);		
	
	
	// Define the ground body.
	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0, 0); // bottom-left corner
	
	// Call the body factory which allocates memory for the ground body
	// from a pool and creates the ground box shape (also from a pool).
	// The body is also added to the world.
	b2Body* groundBody = [[Common instance] getWorld]->CreateBody(&groundBodyDef);
	
	// Define the ground box shape.
	b2EdgeShape groundBox;		
	
	// bottom
	
	groundBox.Set(b2Vec2(0,0), b2Vec2(s.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// top
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO));
	groundBody->CreateFixture(&groundBox,0);
	
	// left
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(0,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// right
	groundBox.Set(b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
}

//-(void) addNewSpriteAtPosition:(CGPoint)p {
//    
//	CCLOG(@"Add sprite %0.2f x %02.f",p.x,p.y);
//	CCNode *parent = [self getChildByTag:kTagParentNode];
//	
//	//We have a 64x64 sprite sheet with 4 different 32x32 images.  The following code is
//	//just randomly picking one of the images
//	int idx = (CCRANDOM_0_1() > .5 ? 0:1);
//	int idy = (CCRANDOM_0_1() > .5 ? 0:1);
//	PhysicsSprite1 *sprite = [PhysicsSprite1 spriteWithTexture:spriteTexture_ rect:CGRectMake(32 * idx,32 * idy,32,32)];						
//	[parent addChild:sprite];
//	
//	sprite.position = ccp( p.x, p.y);
//	
//	// Define the dynamic body.
//	//Set up a 1m squared box in the physics world
//	b2BodyDef bodyDef;
//	bodyDef.type = b2_dynamicBody;
//	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
//	b2Body *body = world->CreateBody(&bodyDef);
//	
//	// Define another box shape for our dynamic body.
//	b2PolygonShape dynamicBox;
//	dynamicBox.SetAsBox(.5f, .5f);//These are mid points for our 1m box
//	
//	// Define the dynamic body fixture.
//	b2FixtureDef fixtureDef;
//	fixtureDef.shape = &dynamicBox;	
//	fixtureDef.density = 1.0f;
//	fixtureDef.friction = 0.3f;
//	body->CreateFixture(&fixtureDef);
//	
//	[sprite setPhysicsBody:body];
//}

-(void) update: (ccTime) dt {
    
//    if (godir == hGoRight) {
//        
//        [hodok goRight];
//    }
//    else {
//        
//        [hodok goLeft];
//    }

	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	[[Common instance] getWorld]->Step(dt, velocityIterations, positionIterations);	
    

}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	//Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
		
		location = [[CCDirector sharedDirector] convertToGL: location];
		
        CGSize s = [CCDirector sharedDirector].winSize;
        NSLog(@"touch x = %f, y = %f",location.x,location.y);
        if (location.x > (s.width / 2)) {
            
            godir = hGoRight;
            [hodok goRight];
        }
        else {

            godir = hGoLeft;
            [hodok goLeft];
        }
        
	}
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    NSLog(@"touch ended");
    godir = hStop;
    [hodok stop];
}

@end
