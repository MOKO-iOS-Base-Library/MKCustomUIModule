//
//  MKBXPTHCurveView.m
//  MKBeaconXPlus_Example
//
//  Created by aa on 2021/3/8.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKBXPTHCurveView.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

static CGFloat const valueLabelWidth = 35.f;
static NSInteger const maxPointCount = 100;

@implementation MKBXPTHCurveViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.lineColor = [UIColor blueColor];
        self.lineWidth = 1.f;
        self.curveViewBackgroundColor = RGBCOLOR(224, 245, 254);
        self.titleColor = DEFAULT_TEXT_COLOR;
        self.titleFont = MKFont(12.f);
        self.yPostionColor = DEFAULT_TEXT_COLOR;
        self.yPostionWidth = CUTTING_LINE_HEIGHT;
        self.labelColor = DEFAULT_TEXT_COLOR;
        self.labelFont = MKFont(10.f);
    }
    return self;
}

@end

@interface MKBXPCurveView : UIView

@property (nonatomic, strong)NSMutableArray *pointList;

@property (nonatomic, strong)UIColor *lineColor;

@property (nonatomic, assign)CGFloat lineWidth;

- (void)updatePointValues:(NSArray <NSString *>*)pointList
                 maxValue:(NSString *)maxValue
                 minValue:(NSString *)minValue;

@end

@implementation MKBXPCurveView

#pragma mark - super method

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGBCOLOR(224, 245, 254);
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self drawCurve];
}

#pragma mark - public method

- (void)updatePointValues:(NSArray <NSString *>*)pointList
                 maxValue:(NSString *)maxValue
                 minValue:(NSString *)minValue {
    if (!ValidArray(pointList)) {
        return;
    }
    [self.pointList removeAllObjects];
    CGFloat totalValue = ([maxValue floatValue] - [minValue floatValue]);
    for (NSInteger i = 0; i < pointList.count; i ++) {
        CGFloat tempValue = self.frame.size.height * ([maxValue floatValue] - [pointList[i] floatValue]) / totalValue;
        [self.pointList addObject:@(tempValue)];
    }
    [self.pointList addObjectsFromArray:pointList];
    [self setNeedsDisplay];
}

#pragma mark - private method

- (void)drawCurve {
    if (!ValidArray(self.pointList)) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, (self.lineWidth > 0 ? self.lineWidth : 1.f));
    UIColor *color = (self.lineColor ? self.lineColor : [UIColor blueColor]);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextMoveToPoint(context, 0, [self.pointList[0] floatValue]);
    CGFloat width = self.frame.size.width / self.pointList.count;
    for (NSInteger i = 1; i < self.pointList.count; i ++) {
        CGContextAddLineToPoint(context, i * width, [self.pointList[i] floatValue]);
    }
    CGContextStrokePath(context);
}

#pragma mark - getter
- (NSMutableArray *)pointList {
    if (!_pointList) {
        _pointList = [NSMutableArray array];
    }
    return _pointList;
}

@end

#define labelSpace (self.frame.size.height - 10 - 5 * MKFont(10.f).lineHeight) / 4
#define curveViewWidth (self.frame.size.width - 60.f)
#define curveViewHeight (self.frame.size.height - 10.f - 2 * MKFont(10.f).lineHeight - 2 * labelSpace)

@interface MKBXPTHCurveView ()<UIScrollViewDelegate>

@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)UIView *horizontalLine;

@property (nonatomic, strong)UILabel *maxLabel;

@property (nonatomic, strong)UILabel *minLabel;

@property (nonatomic, strong)UILabel *aveLabel;

@property (nonatomic, strong)UILabel *valueMaxLabel;

@property (nonatomic, strong)UILabel *valueMinLabel;

@property (nonatomic, strong)MKBXPCurveView *curveView;

@property (nonatomic, strong)UIScrollView *scrollView;

@end

@implementation MKBXPTHCurveView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.horizontalLine];
        [self addSubview:self.maxLabel];
        [self addSubview:self.valueMaxLabel];
        [self addSubview:self.valueMinLabel];
        [self addSubview:self.minLabel];
        [self addSubview:self.aveLabel];
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.curveView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(-40.f);
        make.width.mas_equalTo(120.f);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(20.f);
    }];
    [self.maxLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30.f);
        make.width.mas_equalTo(valueLabelWidth);
        make.top.mas_equalTo(5.f);
        make.height.mas_equalTo(MKFont(10.f).lineHeight);
    }];
    [self.valueMaxLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maxLabel.mas_left);
        make.right.mas_equalTo(self.maxLabel.mas_right);
        make.top.mas_equalTo(self.maxLabel.mas_bottom).mas_offset(labelSpace);
        make.height.mas_equalTo(self.maxLabel.mas_height);
    }];
    [self.aveLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maxLabel.mas_left);
        make.right.mas_equalTo(self.maxLabel.mas_right);
        make.top.mas_equalTo(self.valueMaxLabel.mas_bottom).mas_offset(labelSpace);
        make.height.mas_equalTo(self.maxLabel.mas_height);
    }];
    [self.valueMinLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maxLabel.mas_left);
        make.right.mas_equalTo(self.maxLabel.mas_right);
        make.top.mas_equalTo(self.aveLabel.mas_bottom).mas_offset(labelSpace);
        make.height.mas_equalTo(self.maxLabel.mas_height);
    }];
    [self.minLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maxLabel.mas_left);
        make.right.mas_equalTo(self.maxLabel.mas_right);
        make.bottom.mas_equalTo(-5.f);
        make.height.mas_equalTo(self.maxLabel.mas_height);
    }];
    [self.horizontalLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maxLabel.mas_right).mas_offset(3.f);
        make.width.mas_equalTo(CUTTING_LINE_HEIGHT);
        make.top.mas_equalTo(5.f);
        make.bottom.mas_equalTo(-5.f);
    }];
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.horizontalLine.mas_right);
        make.right.mas_equalTo(-5.f);
        make.top.mas_equalTo(self.valueMaxLabel.mas_centerY);
        make.bottom.mas_equalTo(self.valueMinLabel.mas_centerY);
    }];
    self.curveView.frame = CGRectMake(0, 0, curveViewWidth, curveViewHeight);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollView.contentOffset.x <= 0) {
        CGPoint offset = scrollView.contentOffset;
        offset.x = 0;
        self.scrollView.contentOffset = offset;
    }
}

#pragma mark - public method

- (void)drawCurveWithParamModel:(MKBXPTHCurveViewModel *)dataModel
                      pointList:(NSArray <NSString *>*)pointList
                       maxValue:(NSString *)maxValue
                       minValue:(NSString *)minValue {
    if (!ValidArray(pointList)) {
        return;
    }
    [self configParamsWithModel:dataModel];
    [self.horizontalLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.maxLabel.mas_right).mas_offset(3.f);
        make.width.mas_equalTo(dataModel.yPostionWidth > 0 ? dataModel.yPostionWidth : CUTTING_LINE_HEIGHT);
        make.top.mas_equalTo(5.f);
        make.bottom.mas_equalTo(-5.f);
    }];
    CGFloat tempValue = ([maxValue floatValue] - [minValue floatValue]) / 2;
    self.valueMaxLabel.text = maxValue;
    self.valueMinLabel.text = minValue;
    
    self.maxLabel.text = [NSString stringWithFormat:@"%.1f",[maxValue floatValue] + tempValue];
    self.minLabel.text = [NSString stringWithFormat:@"%.1f",[minValue floatValue] - tempValue];
    self.aveLabel.text = [NSString stringWithFormat:@"%.1f",[minValue floatValue] + tempValue];
    CGFloat tempViewWidth = curveViewWidth;
    if (pointList.count > maxPointCount) {
        CGFloat space = curveViewWidth / maxPointCount;
        tempViewWidth = (pointList.count / maxPointCount) * curveViewWidth + (pointList.count % maxPointCount) * space;
    }
    self.curveView.frame = CGRectMake(0, 0, curveViewWidth, curveViewHeight);
    [self.curveView updatePointValues:pointList maxValue:maxValue minValue:minValue];
    NSInteger totalPage = pointList.count / maxPointCount;
    self.scrollView.contentSize = CGSizeMake(totalPage * curveViewWidth, 0);
    
}

- (void)drawCurveWithPointList:(NSArray <NSString *>*)pointList
                      maxValue:(NSString *)maxValue
                      minValue:(NSString *)minValue {
    MKBXPTHCurveViewModel *dataModel = [[MKBXPTHCurveViewModel alloc] init];
    [self drawCurveWithParamModel:dataModel
                        pointList:pointList
                         maxValue:maxValue
                         minValue:minValue];
}

#pragma mark - private method
- (void)configParamsWithModel:(MKBXPTHCurveViewModel *)paramModel {
    self.curveView.lineColor = (paramModel.lineColor ? paramModel.lineColor : [UIColor blueColor]);
    self.curveView.lineWidth = (paramModel.lineWidth > 0 ? paramModel.lineWidth : 1.f);
    self.curveView.backgroundColor = (paramModel.curveViewBackgroundColor ? paramModel.curveViewBackgroundColor : RGBCOLOR(224, 245, 254));
    self.titleLabel.textColor = (paramModel.titleColor ? paramModel.titleColor : DEFAULT_TEXT_COLOR);
    self.titleLabel.font = (paramModel.titleFont ? paramModel.titleFont : MKFont(12.f));
    self.titleLabel.text = SafeStr(paramModel.curveTitle);
    self.horizontalLine.backgroundColor = (paramModel.yPostionColor ? paramModel.yPostionColor : DEFAULT_TEXT_COLOR);
    self.maxLabel.textColor = (paramModel.labelColor ? paramModel.labelColor : DEFAULT_TEXT_COLOR);
    self.maxLabel.font = (paramModel.labelFont ? paramModel.labelFont : MKFont(10.f));
    self.valueMaxLabel.textColor = (paramModel.labelColor ? paramModel.labelColor : DEFAULT_TEXT_COLOR);
    self.valueMaxLabel.font = (paramModel.labelFont ? paramModel.labelFont : MKFont(10.f));
    self.aveLabel.textColor = (paramModel.labelColor ? paramModel.labelColor : DEFAULT_TEXT_COLOR);
    self.aveLabel.font = (paramModel.labelFont ? paramModel.labelFont : MKFont(10.f));
    self.valueMinLabel.textColor = (paramModel.labelColor ? paramModel.labelColor : DEFAULT_TEXT_COLOR);
    self.valueMinLabel.font = (paramModel.labelFont ? paramModel.labelFont : MKFont(10.f));
    self.minLabel.textColor = (paramModel.labelColor ? paramModel.labelColor : DEFAULT_TEXT_COLOR);
    self.minLabel.font = (paramModel.labelFont ? paramModel.labelFont : MKFont(10.f));
}

#pragma mark - getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = DEFAULT_TEXT_COLOR;
        _titleLabel.font = MKFont(12.f);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"Temperature(℃)";
        
        _titleLabel.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }
    return _titleLabel;
}

- (UIView *)horizontalLine {
    if (!_horizontalLine) {
        _horizontalLine = [[UIView alloc] init];
        _horizontalLine.backgroundColor = DEFAULT_TEXT_COLOR;
    }
    return _horizontalLine;
}

- (UILabel *)maxLabel {
    if (!_maxLabel) {
        _maxLabel = [self loadLabel];
        _maxLabel.text = @"100.9";
    }
    return _maxLabel;
}

- (UILabel *)valueMaxLabel {
    if (!_valueMaxLabel) {
        _valueMaxLabel = [self loadLabel];
        _valueMaxLabel.text = @"100.9";
    }
    return _valueMaxLabel;
}

- (UILabel *)minLabel {
    if (!_minLabel) {
        _minLabel = [self loadLabel];
        _minLabel.text = @"-99.9";
    }
    return _minLabel;
}

- (UILabel *)valueMinLabel {
    if (!_valueMinLabel) {
        _valueMinLabel = [self loadLabel];
        _valueMinLabel.text = @"-10.9";
    }
    return _valueMinLabel;
}

- (UILabel *)aveLabel {
    if (!_aveLabel) {
        _aveLabel = [self loadLabel];
        _aveLabel.text = @"-99.f";
    }
    return _aveLabel;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (MKBXPCurveView *)curveView {
    if (!_curveView) {
        _curveView = [[MKBXPCurveView alloc] init];
    }
    return _curveView;
}

- (UILabel *)loadLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = DEFAULT_TEXT_COLOR;
    label.textAlignment = NSTextAlignmentRight;
    label.font = MKFont(10.f);
    return label;
}

@end
