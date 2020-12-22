//
//  MKCustomUIAdopter.m
//  MKCustomUIModule_Example
//
//  Created by aa on 2020/12/21.
//  Copyright © 2020 aadyx2007@163.com. All rights reserved.
//

#import "MKCustomUIAdopter.h"

@implementation MKCustomUIAdopter

+ (UIButton *)customButtonWithTitle:(NSString *)title
                         titleColor:(UIColor *)titleColor
                    backgroundColor:(UIColor *)backgroundColor
                             target:(nonnull id)target
                             action:(nonnull SEL)action {
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton setTitleColor:titleColor forState:UIControlStateNormal];
    [customButton setBackgroundColor:backgroundColor];
    [customButton.layer setMasksToBounds:YES];
    [customButton.layer setCornerRadius:6.f];
    [customButton addTarget:target
                     action:action
           forControlEvents:UIControlEventTouchUpInside];
    return customButton;
}

@end
