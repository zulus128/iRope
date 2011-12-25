//
//  B2DSprite.h
//  iRope
//
//  Created by вадим on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CCSprite.h"
#import "Box2D.h"

@interface B2DSprite : CCSprite {
    
    b2Body *body_;	// strong ref
}

- (void) setPhysicsBody:(b2Body*)body;
- (b2Body*) getBody;

@end
