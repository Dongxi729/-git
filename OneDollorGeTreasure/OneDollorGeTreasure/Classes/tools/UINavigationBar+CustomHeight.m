//
//  UINavigationBar+CustomHeight.m
//  ShowQiu
//
//  Created by WhiZenBJ on 15/10/29.
//  Copyright © 2015年 WhiZenBJ. All rights reserved.
//

#import "UINavigationBar+CustomHeight.h"
#import "objc/runtime.h"

static char const *const heightKey = "Height";

@implementation UINavigationBar (CustomHeight)

- (void)setHeight:(CGFloat)height {

    objc_setAssociatedObject( self, heightKey, @(height), OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}


- (NSNumber *)height {

    return objc_getAssociatedObject(self, heightKey);
}

- (CGSize)sizeThatFits:(CGSize)size {

    CGSize newSize;
    
    if ( self.height ) {

        newSize = CGSizeMake( self.superview.bounds.size.width, [self.height floatValue] );
    }
    else {

        newSize = [super sizeThatFits:size];
    }
    
    return newSize;
}

@end
