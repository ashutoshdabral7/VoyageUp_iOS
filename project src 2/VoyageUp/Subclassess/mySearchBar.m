//
//  mySearchBar.m
//  AskBaaghil
//
//  Created by Reflections\Reflections mac pro on 14/04/15.
//  Copyright (c) 2015 Reflections Info Systems. All rights reserved.
//

#import "mySearchBar.h"

@implementation mySearchBar
+(UISearchBar *) myCustomSearchBar:(CGRect)rect delegate:(id)delegate  {
    UISearchBar *search = [UISearchBar new];
    search.frame = rect;
    search.showsCancelButton=true;
    search.delegate=delegate;
    [[UISearchBar appearance]setBackgroundColor:[UIColor clearColor]];
    [[UISearchBar appearance] setBackgroundImage:[mySearchBar imageWithColor:[UIColor clearColor]]];
    
    for (UIView *subView in search.subviews)
    {
        for (UIView *secondLevelSubview in subView.subviews){
            if ([secondLevelSubview isKindOfClass:[UITextField class]])
            {
                UITextField *searchBarTextField = (UITextField *)secondLevelSubview;
                
                //set font color here
                searchBarTextField.textColor = [UIColor whiteColor];
                searchBarTextField.font=[UIFont fontWithName:FONT_NAME size:15];
                [searchBarTextField setBorderStyle:UITextBorderStyleNone];
                searchBarTextField.backgroundColor=[UIColor clearColor];
                //searchBarTextField.placeholder=@"Search by keyword";
                searchBarTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Search by keyword" attributes:@{NSForegroundColorAttributeName: [UIColor lightTextColor]}];
                searchBarTextField.textAlignment = NSTextAlignmentLeft;
                //break;
            }
            if ([secondLevelSubview isKindOfClass:[UIButton class]])
            {
                UIButton *cancelButton = (UIButton *)secondLevelSubview;
                [cancelButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
                cancelButton.titleLabel.font=[UIFont fontWithName:FONT_NAME size:15];
                //break;
            }
        }
    }
    return search;
    
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
