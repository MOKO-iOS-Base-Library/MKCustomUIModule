//
//  MKViewCurveController.m
//  MKCustomUIModule_Example
//
//  Created by aa on 2021/3/8.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKViewCurveController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKBXPTHCurveView.h"

@interface MKViewCurveController ()

@property (nonatomic, strong)MKBXPTHCurveView *curveView;

@property (nonatomic, strong)NSMutableArray *pointList;

@end

@implementation MKViewCurveController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultTitle = @"测试曲线图";
    [self.view addSubview:self.curveView];
    [self.curveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5.f);
        make.right.mas_equalTo(-5.f);
        make.top.mas_equalTo(defaultTopInset + 100);
        make.height.mas_equalTo(200.f);
    }];
    [self.rightButton setTitle:@"Draw" forState:UIControlStateNormal];
}

- (void)rightButtonMethod {
//    NSArray *pointList = @[@"15.6",@"17.8",@"18.8",@"10.5",@"-5.6",@"0.0",@"1.5",@"10.5",@"15.6",@"17.8",@"18.8",@"10.5",@"-5.6",@"0.0",@"1.5",@"10.5",@"15.6",@"17.8",@"18.8",@"10.5",@"-5.6",@"0.0",@"1.5",@"10.5",@"15.6",@"17.8",@"18.8",@"10.5",@"-5.6",@"0.0",@"1.5",@"10.5",@"15.6",@"17.8",@"18.8",@"10.5",@"-5.6",@"0.0",@"1.5",@"10.5",@"15.6",@"17.8",@"18.8",@"10.5",@"-5.6",@"0.0",@"1.5",@"10.5",@"15.6",@"17.8",@"18.8",@"10.5",@"-5.6",@"0.0",@"1.5",@"10.5",@"15.6",@"17.8",@"18.8",@"10.5",@"-5.6",@"0.0",@"1.5",@"10.5",@"15.6",@"17.8",@"18.8",@"10.5",@"-5.6",@"0.0",@"1.5",@"10.5"];
    NSArray *pointList = @[
        @"7.0", @"6.9", @"9.5", @"14.5", @"18.2", @"21.5", @"25.2", @"26.5", @"23.3", @"18.3", @"13.9", @"9.6",
        @"7.0", @"6.9", @"9.5", @"14.5", @"18.2", @"21.5", @"25.2", @"26.5", @"23.3", @"18.3", @"13.9", @"9.6",
        @"7.0", @"6.9", @"9.5", @"14.5", @"18.2", @"21.5", @"25.2", @"26.5", @"23.3", @"18.3", @"13.9", @"9.6",
        @"7.0", @"6.9", @"9.5", @"14.5", @"18.2", @"21.5", @"25.2", @"26.5", @"23.3", @"18.3", @"13.9", @"9.6",
        @"7.0", @"6.9", @"9.5", @"14.5", @"18.2", @"21.5", @"25.2", @"26.5", @"23.3", @"18.3", @"13.9", @"9.6",
        @"7.0", @"6.9", @"9.5", @"14.5", @"18.2", @"21.5", @"25.2", @"26.5", @"23.3", @"18.3", @"13.9", @"9.6",
        @"7.0", @"6.9", @"9.5", @"14.5", @"18.2", @"21.5", @"25.2", @"26.5", @"23.3", @"18.3", @"13.9", @"9.6",
        @"7.0", @"6.9", @"9.5", @"14.5", @"18.2", @"21.5", @"25.2", @"26.5", @"23.3", @"18.3", @"13.9", @"9.6",
        @"7.0", @"6.9", @"9.5", @"14.5", @"18.2", @"21.5", @"25.2", @"26.5", @"23.3", @"18.3", @"13.9", @"9.6",
        @"7.0", @"6.9", @"9.5", @"14.5", @"18.2", @"21.5", @"25.2", @"26.5", @"23.3", @"18.3", @"13.9", @"9.6",
        @"7.0", @"6.9", @"9.5", @"14.5", @"18.2", @"21.5", @"25.2", @"26.5", @"23.3", @"18.3", @"13.9", @"9.6",
        @"7.0", @"6.9", @"9.5", @"14.5", @"18.2", @"21.5", @"25.2", @"26.5", @"23.3", @"18.3", @"13.9", @"9.6",
        @"7.0", @"6.9", @"9.5", @"14.5", @"18.2", @"21.5", @"25.2", @"26.5", @"23.3", @"18.3", @"13.9", @"9.6",
        @"7.0", @"6.9", @"9.5", @"14.5", @"18.2", @"21.5", @"25.2", @"26.5", @"23.3", @"18.3", @"13.9", @"9.6",
        @"7.0", @"6.9", @"9.5", @"14.5", @"18.2", @"21.5", @"25.2", @"26.5", @"23.3", @"18.3", @"13.9", @"9.6",
        @"7.0", @"6.9", @"9.5", @"14.5", @"18.2", @"21.5", @"25.2", @"26.5", @"23.3", @"18.3", @"13.9", @"9.6"];
    [self.pointList addObjectsFromArray:pointList];
    [self.curveView drawCurveWithPointList:self.pointList
                                  maxValue:[NSString stringWithFormat:@"%.1f",[[self.pointList valueForKeyPath:@"@max.floatValue"] floatValue]]
                                  minValue:[NSString stringWithFormat:@"%.1f",[[self.pointList valueForKeyPath:@"@min.floatValue"] floatValue]]];
}

- (MKBXPTHCurveView *)curveView {
    if (!_curveView) {
        _curveView = [[MKBXPTHCurveView alloc] init];
    }
    return _curveView;
}

- (NSMutableArray *)pointList {
    if (!_pointList) {
        _pointList = [NSMutableArray array];
    }
    return _pointList;
}

@end
