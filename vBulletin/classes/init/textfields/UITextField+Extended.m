/**
 * @file
 *
 * vBulletin iOS
 * Copyright (c) 2011-2012 Ken Iovino. All Rights Reserved. 
 *
 * This application and it's source code is owned and operated by Ken Iovino. Use of this 
 * application and it's source code is strictly prohibited unless otherwise specified in a written 
 * agreement.
 *
 * This file may not be redistributed in whole or significant part.
 */

#import "UITextField+Extended.h"
#import <objc/runtime.h>

static char defaultHashKey;

@implementation UITextField (Extended)

- (UITextField*) nextField { 
    return objc_getAssociatedObject(self, &defaultHashKey); 
}

- (void) setNextField:(UITextField *)nextField{
    objc_setAssociatedObject(self, &defaultHashKey, nextField, OBJC_ASSOCIATION_RETAIN_NONATOMIC); 
}

@end