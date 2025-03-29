//
//  MKHudManager.m
//  FitPolo
//
//  Created by aa on 17/5/8.
//  Copyright © 2017年 MK. All rights reserved.
//

#import "MKHudManager.h"
#import "MKProgressHUD.h"
#import "MKMacroDefines.h"

@interface MKHudManager ()

@property (nonatomic, strong)UIView *inView;

@property (nonatomic, strong)MKProgressHUD *progressHUD;

@end

@implementation MKHudManager

+ (instancetype)share {
    static dispatch_once_t t;
    static MKHudManager *manager = nil;
    dispatch_once(&t, ^{
        manager = [[MKHudManager alloc] init];
    });
    return manager;
}

- (void)showHUDWithTitle:(NSString *)title
                  inView:(UIView *)inView
           isPenetration:(BOOL)isPenetration {
    if (_progressHUD) {
        [self hide];
    }
    
    _inView = inView ?: kAppWindow;
    
    // Create and configure MKProgressHUD
    _progressHUD = [[MKProgressHUD alloc] initWithView:_inView];
    _progressHUD.removeFromSuperViewOnHide = YES;
    _progressHUD.mode = MKProgressHUDModeIndeterminate;
    
    // Set interaction type based on penetration
    _progressHUD.userInteractionEnabled = !isPenetration;
    
    // Visual customization
    _progressHUD.square = NO;
    _progressHUD.bezelView.layer.cornerRadius = 5.0f;
    _progressHUD.bezelView.backgroundColor = COLOR_WHITE_MACROS;
    _progressHUD.backgroundView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.1f];
    
    // Set text
    _progressHUD.label.font = MKFont(18.f);
    _progressHUD.label.text = title;
    
    // Show in view
    [_inView addSubview:_progressHUD];
    [_progressHUD showAnimated:YES];
}

- (void)showHUDWithTitle:(NSString *)title inView:(UIView *)inView {
    [self showHUDWithTitle:title inView:inView isPenetration:NO];
}

- (void)show {
    if (_progressHUD) {
        [_progressHUD showAnimated:YES];
    }
}

- (void)hide {
    if (_inView) {
        _inView.userInteractionEnabled = YES;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_progressHUD hideAnimated:YES];
        _progressHUD = nil;
    });
}

- (void)hideAfterDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(hide) withObject:nil afterDelay:delay];
}

@end
