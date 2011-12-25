//
//  Common.m
//  iRope
//
//  Created by вадим on 12/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Common.h"

@implementation Common

//@synthesize world;

+ (Common*) instance  {
	
	static Common* instance;
	
	@synchronized(self) {
		
		if(!instance) {
			
			instance = [[Common alloc] init];
		}
	}
	return instance;
}

- (b2World*) getWorld {
    
    return world;
}

- (void) setWorld: (b2World*) w {
    
    world = w;
}

- (id) init{	
	
	self = [super init];
	if(self !=nil) {
        
        
	}
	return self;	
}

-(void) dealloc {
    
//    self.world = NULL;
	
	[super dealloc];
}

@end
