//
//  MainLayer.h
//  iRope
//
//  Created by вадим on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "Hodok.h"
#import "Plate.h"

@interface MainLayer : CCLayer {
    
	CCTexture2D *spriteTexture_;	// weak ref
	GLESDebugDraw *m_debugDraw;		// strong ref
    Hodok* hodok;
    Plate* plate;
    
    int godir;
    
    NSMutableArray* vRopes; //array to hold rope references
}

@end
