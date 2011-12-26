//
//  Plate.h
//  iRope
//
//  Created by Mac on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Box2D.h"

@class CCLayer;
@class B2DSprite;


@interface Plate : NSObject {
    
    CCLayer* lay;
    B2DSprite* sprite;
}

- (id) initWithLayer: (CCLayer*) l; 

- (b2Body*) getBody;

- (void) goUp;

@end
