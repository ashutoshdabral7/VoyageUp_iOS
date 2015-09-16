//
//  customLabel.m
//  AskBaaghil
//
//  Created by Reflections\Reflections mac pro on 29/04/15.
//  Copyright (c) 2015 Reflections Info Systems. All rights reserved.
//

#import "customLabel.h"

@implementation customLabel
//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//       
//        
//    }
//    return self;
//}
+(UILabel *) customLabelWithFrame:(CGRect)rect withText:(NSString*)title withColor:(UIColor*)color 
{
    
    UILabel *lable= [UILabel new];
    [lable setBackgroundColor:[UIColor clearColor]];
    lable.frame=rect;
    lable.text=title;
    lable.numberOfLines = 5;
    lable.textColor=color;
    lable.lineBreakMode = NSLineBreakByWordWrapping;
       lable.textAlignment = NSTextAlignmentCenter;
    
    return lable;
}
+ (UILabel *) SetNavTitle:(NSString *) title{
    UILabel *Label = [[UILabel alloc]initWithFrame:CGRectMake(0,0,50,40)];
    Label.text = title;
    Label.backgroundColor = [UIColor clearColor];
    Label.font = [UIFont fontWithName:@"NeoSans-Bold" size:24];
    [Label setTextColor:COLOR_TEXT];
    return Label;
}
+(UILabel *) customLabelWithFrame:(CGRect)rect withText:(NSString*)title withColor:(UIColor*)color withline:(long)linenumber
{
    
    UILabel *lable= [UILabel new];
    [lable setBackgroundColor:[UIColor clearColor]];
    lable.frame=rect;
    lable.text=title;
    lable.numberOfLines = linenumber;
    lable.textColor=color;
    lable.lineBreakMode = NSLineBreakByWordWrapping;
    lable.textAlignment = NSTextAlignmentJustified;
    if(linenumber == 0 )
        [lable  setFont: [UIFont fontWithName:FONT_MONT_LIGHT size:15]];
    else
        [lable  setFont: [UIFont fontWithName:FONT_MONT_LIGHT size:17]];
    return lable;
}


-(void)setColor:(UIColor *)color
{
    self.textColor = color;
}
@end
