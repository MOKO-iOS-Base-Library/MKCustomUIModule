//
//  MKProgressHUD.h
//  MKCustomUIModule_Example
//
//  Created by aa on 2025/3/28.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern CGFloat const MKProgressMaxOffset;

typedef NS_ENUM(NSInteger, MKProgressHUDMode) {
    MKProgressHUDModeIndeterminate,
    MKProgressHUDModeDeterminate,
    MKProgressHUDModeDeterminateHorizontalBar,
    MKProgressHUDModeAnnularDeterminate,
    MKProgressHUDModeCustomView,
    MKProgressHUDModeText
};

typedef NS_ENUM(NSInteger, MKProgressHUDAnimation) {
    MKProgressHUDAnimationFade,
    MKProgressHUDAnimationZoom,
    MKProgressHUDAnimationZoomOut,
    MKProgressHUDAnimationZoomIn
};

typedef NS_ENUM(NSInteger, MKProgressHUDBackgroundStyle) {
    MKProgressHUDBackgroundStyleSolidColor
};

typedef void (^MKProgressHUDCompletionBlock)(void);

@class MKProgressHUD;
@protocol MKProgressHUDDelegate <NSObject>
@optional
- (void)hudWasHidden:(MKProgressHUD *)hud;
@end

@interface MKProgressHUD : UIView

// Class methods
+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;
+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;
+ (nullable MKProgressHUD *)HUDForView:(UIView *)view;

// Initializers
- (instancetype)initWithView:(UIView *)view;

// Show/hide methods
- (void)showAnimated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay;

// Properties
@property (weak, nonatomic) id<MKProgressHUDDelegate> delegate;
@property (copy, nullable) MKProgressHUDCompletionBlock completionBlock;
@property (assign, nonatomic) NSTimeInterval graceTime;
@property (assign, nonatomic) NSTimeInterval minShowTime;
@property (assign, nonatomic) BOOL removeFromSuperViewOnHide;

// Appearance
@property (assign, nonatomic) MKProgressHUDMode mode;
@property (strong, nonatomic, nullable) UIColor *contentColor;
@property (assign, nonatomic) MKProgressHUDAnimation animationType;
@property (assign, nonatomic) CGPoint offset;
@property (assign, nonatomic) CGFloat margin;
@property (assign, nonatomic) CGSize minSize;
@property (assign, nonatomic, getter=isSquare) BOOL square;

// Progress
@property (assign, nonatomic) float progress;
@property (strong, nonatomic, nullable) NSProgress *progressObject;

// Views
@property (strong, nonatomic, readonly) UIView *bezelView;
@property (strong, nonatomic, readonly) UIView *backgroundView;
@property (strong, nonatomic, nullable) UIView *customView;
@property (strong, nonatomic, readonly) UILabel *label;
@property (strong, nonatomic, readonly) UILabel *detailsLabel;
@property (strong, nonatomic, readonly) UIButton *button;

@end

@interface MKRoundProgressView : UIView
@property (nonatomic, assign) float progress;
@property (nonatomic, strong) UIColor *progressTintColor;
@property (nonatomic, strong) UIColor *backgroundTintColor;
@property (nonatomic, assign, getter=isAnnular) BOOL annular;
@end

@interface MKBarProgressView : UIView
@property (nonatomic, assign) float progress;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *progressRemainingColor;
@property (nonatomic, strong) UIColor *progressColor;
@end

@interface MKBackgroundView : UIView
@property (nonatomic) MKProgressHUDBackgroundStyle style;
@property (nonatomic, strong, nullable) UIColor *color;
@end

NS_ASSUME_NONNULL_END
