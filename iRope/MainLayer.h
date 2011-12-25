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

@interface MainLayer : CCLayer {
    
	CCTexture2D *spriteTexture_;	// weak ref
	GLESDebugDraw *m_debugDraw;		// strong ref
    Hodok* hodok;
    
    int godir;
}

@end
