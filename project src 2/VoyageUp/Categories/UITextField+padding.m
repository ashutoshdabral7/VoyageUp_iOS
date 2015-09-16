//
//  UITextField+padding.m
//  InKit
//
//  Created by Reflections\Reflections mac pro on 04/02/15.
//  Copyright (c) 2015 Reflections. All rights reserved.
//

#import "UITextField+padding.h"

@implementation UITextField (padding)

-(void)leftViewRectForBounds
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}
@end
