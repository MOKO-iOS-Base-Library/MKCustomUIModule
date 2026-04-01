//
//  MKBaseViewController.m
//  FitPolo
//
//  Created by aa on 17/5/7.
//  Copyright © 2017年 MK. All rights reserved.
//

#import "MKBaseViewController.h"
#import "MKMacroDefines.h"
#import "MKDeviceDefine.h"
#import "UIButton+MKAdd.h"

@interface MKBaseViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIView *customNavBarView;

@end

@implementation MKBaseViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR_WHITE_MACROS;
    [self setupCustomNavigationBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 隐藏系统导航栏，使用自定义导航栏
    self.navigationController.navigationBarHidden = YES;
    
    // 确保自定义导航栏在最前面
    if (self.customNavBarView) {
        [self.view bringSubviewToFront:self.customNavBarView];
    }
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.customNavBarView) {
        [self.view bringSubviewToFront:self.customNavBarView];
        [self updateCustomNavBarFrame];
        [self adjustSubviewsFrame];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

#pragma mark - Setup Custom Navigation Bar
- (void)setupCustomNavigationBar {
    // 移除旧的导航栏
    [self.customNavBarView removeFromSuperview];
    
    // 使用宏定义获取状态栏和导航栏高度
    CGFloat statusBarHeight = kStatusBarHeight;
    CGFloat navBarHeight = kNavigationBarHeight;
    CGFloat totalHeight = kTopBarHeight;
    
    // 创建自定义导航栏
    self.customNavBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, totalHeight)];
    self.customNavBarView.backgroundColor = [self getNavBarBackgroundColor];
    self.customNavBarView.userInteractionEnabled = YES;
    [self.view addSubview:self.customNavBarView];
    
    // 添加左按钮
    self.leftButton.frame = CGRectMake(0, statusBarHeight, 44, navBarHeight);
    [self.customNavBarView addSubview:self.leftButton];
    
    // 添加标题
    self.titleLabel.frame = CGRectMake(60, statusBarHeight, kViewWidth - 120, navBarHeight);
    [self.customNavBarView addSubview:self.titleLabel];
    
    // 添加右按钮
    self.rightButton.frame = CGRectMake(kViewWidth - 44, statusBarHeight, 44, navBarHeight);
    [self.customNavBarView addSubview:self.rightButton];
}

#pragma mark - Update Navigation Bar
- (void)updateNavigationBarAppearance {
    if (!self.customNavBarView) {
        return;
    }
    
    // 更新背景色
    self.customNavBarView.backgroundColor = [self getNavBarBackgroundColor];
    
    // 更新标题颜色
    self.titleLabel.textColor = [self getNavBarTitleColor];
    
    // 更新按钮颜色
    UIColor *buttonColor = [self getNavBarButtonColor];
    [self.leftButton setTitleColor:buttonColor forState:UIControlStateNormal];
    [self.rightButton setTitleColor:buttonColor forState:UIControlStateNormal];
}

- (void)updateCustomNavBarFrame {
    CGFloat totalHeight = kTopBarHeight;
    
    CGRect frame = self.customNavBarView.frame;
    frame.size.width = kViewWidth;
    frame.size.height = totalHeight;
    self.customNavBarView.frame = frame;
}

- (void)adjustSubviewsFrame {
    CGFloat statusBarHeight = kStatusBarHeight;
    CGFloat navBarHeight = kNavigationBarHeight;
    CGFloat totalHeight = kTopBarHeight;
    
    // 调整按钮和标题位置
    self.leftButton.frame = CGRectMake(0, statusBarHeight, 44, navBarHeight);
    self.rightButton.frame = CGRectMake(kViewWidth - 44, statusBarHeight, 44, navBarHeight);
    self.titleLabel.frame = CGRectMake(60, statusBarHeight, kViewWidth - 120, navBarHeight);
    
    // 调整其他子视图，避免被导航栏遮挡
    for (UIView *subview in self.view.subviews) {
        if (subview != self.customNavBarView &&
            subview != self.leftButton &&
            subview != self.rightButton &&
            subview != self.titleLabel) {
            CGRect frame = subview.frame;
            if (frame.origin.y < totalHeight && frame.origin.y > 0) {
                frame.origin.y = totalHeight;
                frame.size.height = kViewHeight - totalHeight - kSafeAreaHeight;
                subview.frame = frame;
            }
        }
    }
}

#pragma mark - Color Configuration (子类可重写)
- (UIColor *)getNavBarBackgroundColor {
    if (self.navBarBackgroundColor) {
        return self.navBarBackgroundColor;
    }
    return NAVBAR_COLOR_MACROS;
}

- (UIColor *)getNavBarTitleColor {
    return COLOR_WHITE_MACROS;
}

- (UIColor *)getNavBarButtonColor {
    return COLOR_WHITE_MACROS;
}

#pragma mark - Setter
- (void)setNavBarBackgroundColor:(UIColor *)navBarBackgroundColor {
    _navBarBackgroundColor = navBarBackgroundColor;
    [self updateNavigationBarAppearance];
}

- (void)setDefaultTitle:(NSString *)defaultTitle {
    _defaultTitle = defaultTitle;
    NSString *titleText = self.title ?: defaultTitle;
    self.titleLabel.text = titleText;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([self isRootViewController]) {
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - Actions
- (void)leftButtonMethod {
    if (self.isPrensent) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)rightButtonMethod {
    // 子类重写
}

#pragma mark - Other Methods
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

+ (BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController {
    return (viewController.isViewLoaded && viewController.view.window);
}

- (void)popToViewControllerWithClassName:(NSString *)className {
    UIViewController *popController = nil;
    for (UIViewController *v in self.navigationController.viewControllers) {
        if ([v isKindOfClass:NSClassFromString(className)]) {
            popController = v;
            break;
        }
    }
    if (popController) {
        [self.navigationController popToViewController:popController animated:YES];
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (BOOL)isRootViewController {
    return (self == self.navigationController.viewControllers.firstObject);
}

#pragma mark - Lazy Load
- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        
        UIImage *backImage = LOADICON(@"MKBaseModuleLibrary", @"MKBaseViewController", @"navigation_back_button_white.png");
        backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_leftButton setImage:backImage forState:UIControlStateNormal];
        
        _leftButton.imageView.contentMode = UIViewContentModeCenter;
        _leftButton.adjustsImageWhenHighlighted = NO;
        [_leftButton addTarget:self action:@selector(leftButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.acceptEventInterval = 1.f;
        _leftButton.backgroundColor = [UIColor clearColor];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_rightButton.titleLabel setFont:MKFont(16)];
        [_rightButton setTitleColor:COLOR_WHITE_MACROS forState:UIControlStateNormal];
        [_rightButton setTitleColor:RGBACOLOR(255, 255, 255, 0.6) forState:UIControlStateHighlighted];
        [_rightButton addTarget:self action:@selector(rightButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.acceptEventInterval = 1.f;
        _rightButton.backgroundColor = [UIColor clearColor];
        _rightButton.adjustsImageWhenHighlighted = NO;
    }
    return _rightButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = MKFont(20);
        _titleLabel.textColor = COLOR_WHITE_MACROS;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}

@end
