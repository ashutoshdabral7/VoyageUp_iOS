//
//  myButton.h
//  AskBaaghil
//
//  Created by Reflections\Reflections mac pro on 13/04/15.
//  Copyright (c) 2015 Reflections Info Systems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myButton : UIButton{
    
}
+(UIButton *) buttonWithMyStyleinitwithFrame:(CGRect)rect withTitle:(NSString*)title withImage:(UIImage*)img state:(BOOL)status ;
+ (UIImage *)imageWithColor:(UIColor *)color;
@property (nonatomic,strong)NSString *title;
+(UIBarButtonItem*)customBarbuttonWithFrame:(CGRect)rect withImage:(UIImage*)title forSelector:(SEL)selector target:(id)target;
+(UIBarButtonItem*)customBarbuttonWithFrame:(CGRect)rect withTitle:(NSString*)title forSelector:(SEL)selector target:(id)target;
@end
