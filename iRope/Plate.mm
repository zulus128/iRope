//
//  Plate.m
//  iRope
//
//  Created by Mac on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Plate.h"

#import "cocos2d.h"
#import "Common.h"
#import "B2DSprite.h"
//#import "Box2D.h"

@implementation Plate

- (id) initWithLayer: (CCLayer*) l {
    
    self = [super init];
	if(self !=nil) {
        
        lay = l;
        
        CCLOG(@"Add hodok");
        CCNode *parent = [lay getChildByTag:kTagParentNode];
        
        sprite = [B2DSprite spriteWithSpriteFrameName:@"plate.png"];
        [parent addChild:sprite z:0];
        
        CGPoint p = ccp(150, 200);
        sprite.position = p;
        
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
        
        body->SetGravityScale(0);
        
//        b2Vec2 force = [sprite getBody]->GetWorldPoint(b2Vec2(0.0f, 100.0f));
//        b2Vec2 point = [sprite getBody]->GetWorldPoint(b2Vec2(0.0f, 0.0f));
//        [sprite getBody]->ApplyForce(force, point);   

        
	}
	return self;	
}

- (void) goUp {
    
    b2Vec2 force = [sprite getBody]->GetWorldPoint(b2Vec2(0.0f, 0.0f));
    force.y = force.y + 200;
    b2Vec2 point = [sprite getBody]->GetWorldPoint(b2Vec2(0.0f, 0.0f));
    [sprite getBody]->ApplyForce(force, point);   
}

- (b2Body*) getBody {
    
    return [sprite getBody];
}

@end
