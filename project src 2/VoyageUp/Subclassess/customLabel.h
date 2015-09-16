//
//  customLabel.h
//  AskBaaghil
//
//  Created by Reflections\Reflections mac pro on 29/04/15.
//  Copyright (c) 2015 Reflections Info Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customLabel : UILabel
@property (strong, nonatomic) UIColor *color;
+(UILabel *) customLabelWithFrame:(CGRect)rect withText:(NSString*)title withColor:(UIColor*)color ;
+ (UILabel *) SetNavTitle:(NSString *) title;
+(UILabel *) customLabelWithFrame:(CGRect)rect withText:(NSString*)title withColor:(UIColor*)color withline:(long)linenumber;
@end
