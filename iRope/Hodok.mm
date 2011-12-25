//
//  Hodok.m
//  iRope
//
//  Created by вадим on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Hodok.h"
#import "cocos2d.h"
#import "Common.h"
#import "B2DSprite.h"
#import "Box2D.h"

@implementation Hodok

- (id) initWithLayer: (CCLayer*) l {
    
    self = [super init];
	if(self !=nil) {
        
        lay = l;
        
        CCLOG(@"Add hodok");
        CCNode *parent = [lay getChildByTag:kTagParentNode];

        sprite = [B2DSprite spriteWithSpriteFrameName:@"alien.png"];
        [parent addChild:sprite z:0];
        
        CGPoint p = ccp(100, 100);
        sprite.position = p;

//        [sprite runAction:[CCMoveTo actionWithDuration:5.0f position:ccp(200, 200)]];

        
        //We have a 64x64 sprite sheet with 4 different 32x32 images.  The following code is
        //just randomly picking one of the images
//        int idx = (CCRANDOM_0_1() > .5 ? 0:1);
//        int idy = (CCRANDOM_0_1() > .5 ? 0:1);
//        PhysicsSprite1 *sprite = [PhysicsSprite1 spriteWithTexture:spriteTexture_ rect:CGRectMake(32 * idx,32 * idy,32,32)];						
//        [parent addChild:sprite];
//        
//        sprite.position = ccp( p.x, p.y);
        
        // Define the dynamic body.
        //Set up a 1m squared box in the physics world
        b2BodyDef bodyDef;
        bodyDef.type = b2_dynamicBody;
        bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
        b2Body *body = [[Common instance] getWorld]->CreateBody(&bodyDef);
        
        // Define another box shape for our dynamic body.
        b2PolygonShape dynamicBox;
//        dynamicBox.SetAsBox(.5f, .5f);//These are mid points for our 1m box
        dynamicBox.SetAsBox(1.0f, 1.0f);//These are mid points for our 1m box
        
        // Define the dynamic body fixture.
        b2FixtureDef fixtureDef;
        fixtureDef.shape = &dynamicBox;	
        fixtureDef.density = 1.0f;
        fixtureDef.friction = 0.3f;
        body->CreateFixture(&fixtureDef);
        
        [sprite setPhysicsBody:body];
	}
	return self;	
}

- (void) goRight {

    b2Vec2 force = [sprite getBody]->GetWorldPoint(b2Vec2(0.0f, 0.0f));
    force.x = force.x + 1000;
    //    force.y = 0;
    //    CCLOG(@"Force: %f, %f", force.x, force.y);
    //    CCLOG(@"Angle: %.4f", game.angle);
    b2Vec2 point = [sprite getBody]->GetWorldPoint(b2Vec2(0.0f, 0.0f));
    [sprite getBody]->ApplyForce(force, point);   
}

- (void) goLeft {

    b2Vec2 force = [sprite getBody]->GetWorldPoint(b2Vec2(0.0f, 0.0f));
    force.x = force.x - 1000;
    //    force.y = 0;
    //    CCLOG(@"Force: %f, %f", force.x, force.y);
    //    CCLOG(@"Angle: %.4f", game.angle);
    b2Vec2 point = [sprite getBody]->GetWorldPoint(b2Vec2(0.0f, 0.0f));
    [sprite getBody]->ApplyForce(force, point);   

}

- (void) stop {

}

@end
