//
//  MKBaseViewController.h
//  FitPolo
//
//  Created by aa on 17/5/7.
//  Copyright © 2017年 MK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKBaseViewController : UIViewController

/**
 *  标题label
 */
@property (nonatomic, strong, readonly) UILabel *titleLabel;
/**
 *  左按钮
 */
@property (nonatomic, strong, readonly) UIButton *leftButton;
/**
 *  右按钮
 */
@property (nonatomic, strong, readonly) UIButton *rightButton;
/**
 *  controlle是否是 经过 presentViewController:animated:completion: 推出来，默认为NO
 */
@property (nonatomic, assign) BOOL isPrensent;
/**
 标题栏文字
 */
@property (nonatomic, copy) NSString *defaultTitle;

/**
 导航栏背景色（默认使用 NAVBAR_COLOR_MACROS）
 */
@property (nonatomic, strong, nullable) UIColor *navBarBackgroundColor;

/**
 *  左按钮方法
 */
- (void)leftButtonMethod;

/**
 *  右按钮方法
 */
- (void)rightButtonMethod;

/**
 *  判断当前显示的是否是本控制器
 */
+ (BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController;

/**
 *  返回到指定类名的控制器
 */
- (void)popToViewControllerWithClassName:(NSString *)className;

/**
 *  刷新导航栏样式（子类可重写颜色配置方法）
 */
- (void)updateNavigationBarAppearance;

/**
 *  获取导航栏背景色（子类可重写）
 */
- (UIColor *)getNavBarBackgroundColor;

/**
 *  获取导航栏标题颜色（子类可重写）
 */
- (UIColor *)getNavBarTitleColor;

/**
 *  获取导航栏按钮颜色（子类可重写）
 */
- (UIColor *)getNavBarButtonColor;

@end

NS_ASSUME_NONNULL_END
