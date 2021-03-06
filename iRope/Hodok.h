//
//  Hodok.h
//  iRope
//
//  Created by вадим on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Box2D.h"

@class CCLayer;
@class B2DSprite;

@interface Hodok : NSObject {
    
    CCLayer* lay;
    B2DSprite* sprite;
}

- (id) initWithLayer: (CCLayer*) l; 

- (void) goRight;
- (void) goLeft;
- (void) stop;

- (b2Body*) getBody;

@end
