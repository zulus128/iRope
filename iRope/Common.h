//
//  Common.h
//  iRope
//
//  Created by вадим on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"

#define PTM_RATIO 32

enum {
	kTagParentNode = 1,
};

enum {
	hStop = 0,
	hGoRight = 1,
	hGoLeft = 2,
};

@interface Common : NSObject {
    
    b2World* world;
}

+ (Common*) instance;

//@property (nonatomic, retain) b2World* world;

- (b2World*) getWorld;
- (void) setWorld: (b2World*) w;

@end
