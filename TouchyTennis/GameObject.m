//
//  GameObject.m
//  TouchyTennis
//
//  Created by AJ Austinson on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"

@implementation GameObject

+ (id <CAAction> )defaultActionForKey:(NSString *)event {
    return (id<CAAction>)[NSNull null];
}

@end
