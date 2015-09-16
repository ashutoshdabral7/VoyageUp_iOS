//
//  myButton.m
//  AskBaaghil
//
//  Created by Reflections\Reflections mac pro on 13/04/15.
//  Copyright (c) 2015 Reflections Info Systems. All rights reserved.
//

#import "myButton.h"

@implementation myButton
+(UIButton *) buttonWithMyStyleinitwithFrame:(CGRect)rect withTitle:(NSString*)title withImage:(UIImage*)img state:(BOOL)status  {
    UIButton *theButton = [UIButton buttonWithType:UIButtonTypeCustom];
    theButton.frame=rect;
    //[theButton setHighlighted:status];
    [theButton.titleLabel setFont: [UIFont fontWithName:FONT_NAME size:14]];
    [theButton setTitle:title forState:UIControlStateNormal];
    //[theButton setBackgroundColor:[UIColor greenColor]];
    [theButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   [theButton setBackgroundImage:[self imageWithColor:CUSTOM_DARK_BLUE] forState:UIControlStateNormal];
    [theButton setBackgroundImage:[self imageWithColor:CUSTOM_LIGHT_BLUE] forState:UIControlStateHighlighted];
    
    if (img!=nil) {
       [theButton setImage:img forState:UIControlStateNormal];
    }
     return theButton;
   
}
+(UIBarButtonItem*)customBarbuttonWithFrame:(CGRect)rect withImage:(UIImage*)title forSelector:(SEL)selector target:(id)target
{
    
    UIButton *favButton = [[UIButton alloc] init];
   // [favButton setTitle:title forState:UIControlStateNormal];
    [favButton setImage:title forState:UIControlStateNormal];
    favButton.titleLabel.font=[UIFont fontWithName:FONT_NAME size:17];
    [favButton addTarget:target action:selector
        forControlEvents:UIControlEventTouchUpInside];
    [favButton setFrame:rect];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:favButton];
    
    return button;
    
    
}
+(UIBarButtonItem*)customBarbuttonWithFrame:(CGRect)rect withTitle:(NSString*)title forSelector:(SEL)selector target:(id)target
{
    
    UIButton *favButton = [UIButton new];
    [favButton setTitle:title forState:UIControlStateNormal];
    favButton.titleLabel.font=[UIFont fontWithName:FONT_NAME size:17];
   // [favButton setTitleColor:COLOR_MAIN_BG];
    [favButton addTarget:target action:selector
        forControlEvents:UIControlEventTouchUpInside];
    [favButton setFrame:rect];
    favButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithCustomView:favButton];
    return button;
    
    
}
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
/*
 /// 
 if (doText) {
 _duration = 4;
 UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - 50, 0, 50, CGRectGetHeight(self.frame))];
 
 [rightBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
 
 NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:doText];
 NSRange contentRange = {0,[content length]};
 [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
 [content addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:contentRange];
 [rightBtn setAttributedTitle:content forState:UIControlStateNormal];
 
 [rightBtn setBackgroundImage:[self createImageWithColor:self.backgroundColor] forState:UIControlStateNormal];
 [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
 
 CGSize size = MOZ_TEXTSIZE(doText, rightBtn.titleLabel.font);
 
 CGFloat rightBtnWidth = size.width + 14;
 rightBtn.frame = CGRectMake(CGRectGetWidth(self.frame) - rightBtnWidth, 0, rightBtnWidth, CGRectGetHeight(self.frame));
 
 textLabel.frame = CGRectMake((width - textLabelWidth)*0.5, 0, textLabelWidth + 30 - rightBtnWidth, CGRectGetHeight(self.frame));
 
 [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
 [self addSubview:rightBtn];
 UIView *rightLine = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - rightBtnWidth - 3, 0, 3, CGRectGetHeight(self.frame))];
 rightLine.backgroundColor = [UIColor whiteColor];
 [self addSubview:rightLine];
 }*/