//
//  MKTestViewController.m
//  MKCustomUIModule_Example
//
//  Created by aa on 2020/12/21.
//  Copyright © 2020 aadyx2007@163.com. All rights reserved.
//

#import "MKTestViewController.h"

#import <MKBaseModuleLibrary/MKMacroDefines.h>
#import <MKBaseModuleLibrary/MKBaseTableView.h>

#import <Masonry/Masonry.h>
#import <MLInputDodger/MLInputDodger.h>

#import <MKCustomUIModule/MKTextFieldCell.h>
#import <MKCustomUIModule/MKTextButtonCell.h>
#import <MKCustomUIModule/MKNormalTextCell.h>
#import <MKCustomUIModule/MKMeasureTxPowerCell.h>
#import <MKCustomUIModule/MKTextSwitchCell.h>
#import <MKCustomUIModule/MKFilterDataCell.h>

#import <MKCustomUIModule/MKSlider.h>

#import <MKCustomUIModule/MKTrackerAboutController.h>
#import <MKCustomUIModule/MKTrackerLogController.h>

#import <MKCustomUIModule/MKCustomUIAdopter.h>

#import <MKCustomUIModule/MKSearchButton.h>
#import <MKCustomUIModule/MKSearchConditionsView.h>

@interface MKTrackerAboutModel : NSObject<MKTrackerAboutParamsProtocol>

/// 导航栏标题
@property (nonatomic, copy, nullable)NSString *title;

/// 导航栏title颜色
@property (nonatomic, strong, nullable)UIColor *titleColor;

/// 顶部导航栏背景颜色
@property (nonatomic, strong, nullable)UIColor *titleBarColor;

/// 最上面那个关于的icon, 宽高都是110个点
@property (nonatomic, strong, nullable)UIImage *aboutIcon;

/// 底部背景图片,宽度为当前屏幕宽度，213个点的高度
@property (nonatomic, strong, nullable)UIImage *bottomBackIcon;

@property (nonatomic, copy, nullable)NSString *appName;

@property (nonatomic, copy, nullable)NSString *appVersion;

@end

@implementation MKTrackerAboutModel
@end

@interface MKTrackerLogModel : NSObject<MKTrackerLogPageProtocol>

/// 导航栏标题，默认@"Log"
@property (nonatomic, copy)NSString *title;

/// 导航栏title颜色,默认白色
@property (nonatomic, strong)UIColor *titleColor;

/// 顶部导航栏背景颜色，默认蓝色
@property (nonatomic, strong)UIColor *titleBarColor;

/// 最上面那个icon
@property (nonatomic, strong)UIImage *emailIcon;

/// icon和button中间那个label的msg
@property (nonatomic, copy)NSString *msg;

/// icon和button中间那个label字体颜色,默认#353535
@property (nonatomic, strong)UIColor *msgColor;

/// icon和button中间那个label字体大小，默认15
@property (nonatomic, strong)UIFont *msgFont;

/// 发送按钮的背景颜色
@property (nonatomic, strong)UIColor *buttonBackColor;

/// 发送按钮的title颜色，默认#2F84D0
@property (nonatomic, strong)UIColor *buttonTitleColor;

/// 发送按钮的title字体大小，默认15
@property (nonatomic, strong)UIFont *buttonLabelFont;

/// 按钮标题，默认Email
@property (nonatomic, copy)NSString *buttonTitle;

@end

@implementation MKTrackerLogModel
@end

@interface MKTestViewController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextFieldCellDelegate,
MKTextButtonCellDelegate,
MKMeasureTxPowerCellDelegate,
mk_textSwitchCellDelegate,
MKSearchButtonDelegate,
MKFilterDataCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)NSMutableArray *section5List;

@end

@implementation MKTestViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadTableDatas];
}

#pragma mark - super method

- (void)rightButtonMethod {
    
}

- (void)leftButtonMethod {
    MKTrackerLogModel *viewModel = [[MKTrackerLogModel alloc] init];
    viewModel.emailIcon = LOADIMAGE(@"aboutIcon", @"png");
    MKTrackerLogController *vc = [[MKTrackerLogController alloc] initWithProtocol:viewModel localFileName:@"mk_log"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextFieldCellModel *cellModel = self.section0List[indexPath.row];
        return [cellModel cellHeightWithContentWidth:kViewWidth];
    }
    if (indexPath.section == 1) {
        MKTextButtonCellModel *cellModel = self.section1List[indexPath.row];
        return [cellModel cellHeightWithContentWidth:kViewWidth];
    }
    if (indexPath.section == 2) {
        MKNormalTextCellModel *cellModel = self.section2List[indexPath.row];
        return [cellModel cellHeightWithContentWidth:kViewWidth];
    }
    if (indexPath.section == 3) {
        return 120.f;
    }
    if (indexPath.section == 4) {
        MKTextSwitchCellModel *cellModel = self.section4List[indexPath.row];
        return [cellModel cellHeightWithContentWidth:kViewWidth];
    }
    if (indexPath.section == 5) {
        MKFilterDataCellModel *cellModel = self.section5List[indexPath.row];
        return (cellModel.isOn ? 145.f : 60.f);
    }
    return 44.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    if (section == 2) {
        return self.section2List.count;
    }
    if (section == 3) {
        return self.section3List.count;
    }
    if (section == 4) {
        return self.section4List.count;
    }
    if (section == 5) {
        return self.section5List.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        MKTextButtonCell *cell = [MKTextButtonCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 2) {
        MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
        cell.dataModel = self.section2List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 3) {
        MKMeasureTxPowerCell *cell = [MKMeasureTxPowerCell initCellWithTableView:tableView];
        cell.dataModel = self.section3List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 4) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section4List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKFilterDataCell *cell = [MKFilterDataCell initCellWithTableView:tableView];
    cell.dataModel = self.section5List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKTextFieldCellDelegate
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    NSLog(@"我靠，吓死我了，值发生改变了:%@-%@",@(index),value);
}

#pragma mark - MKTextButtonCellDelegate
- (void)mk_loraTextButtonCellSelected:(NSInteger)index
                        dataListIndex:(NSInteger)dataListIndex
                                value:(NSString *)value {
    
}

#pragma mark - MKMeasureTxPowerCellDelegate
- (void)mk_measureTxPowerCell_measurePowerValueChanged:(NSString *)measurePower {
    NSLog(@"当前设备的measurePower变化了:%@",measurePower);
}

- (void)mk_measureTxPowerCell_txPowerValueChanged:(mk_deviceTxPower)txPower {
    NSLog(@"当前设备的txPower变化了:%@",@(txPower));
}

#pragma mark - mk_textSwitchCellDelegate
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    NSLog(@"当前开关状态发生改变了:%@-%@",@(isOn),@(index));
}

#pragma mark - MKSearchButtonDelegate
- (void)mk_scanSearchButtonMethod {
    [MKSearchConditionsView showSearchKey:@"bb" rssi:-66 minRssi:-100 searchBlock:^(NSString * _Nonnull searchKey, NSInteger searchRssi) {
        NSLog(@"选择了:%@-%@",searchKey,@(searchRssi));
    }];
    
}

- (void)mk_scanSearchButtonClearMethod {
    
}

#pragma mark - MKFilterDataCellDelegate
- (void)mk_fliterSwitchStatusChanged:(BOOL)isOn index:(NSInteger)index {
    NSLog(@"当前开关状态变了:%@-------%@",@(index),@(isOn));
    MKFilterDataCellModel *cellModel = self.section5List[index];
    cellModel.isOn = isOn;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)mk_listButtonStateChanged:(BOOL)selected index:(NSInteger)index {
    NSLog(@"当前按钮状态变了:%@-------%@",@(index),@(selected));
}

- (void)mk_filterTextFieldValueChanged:(NSString *)value index:(NSInteger)index {
    NSLog(@"当前输入框值发生了改变:%@----------%@",value,@(index));
}

- (void)mk_leftFilterTextFieldValueChanged:(NSString *)value index:(NSInteger)index {
    NSLog(@"当前左侧输入框发生改变:%@+++++++++%@",value,@(index));
}

- (void)mk_rightFilterTextFieldValueChanged:(NSString *)value index:(NSInteger)index {
    NSLog(@"当前右侧输入框发生改变:%@+++++++++%@",value,@(index));
}

#pragma mark - event method

- (void)pushAboutPage {
    MKTrackerAboutModel *model = [[MKTrackerAboutModel alloc] init];
    model.aboutIcon = LOADIMAGE(@"slot_frameType", @"png");
    MKTrackerAboutController *vc = [[MKTrackerAboutController alloc] initWithProtocol:model];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Private method

- (void)loadTableDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    [self loadSection4Datas];
    [self loadSection5Datas];
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextFieldCellModel *cellModel1 = [[MKTextFieldCellModel alloc] init];
    cellModel1.msg = @"第一个测试项第一个测试项第一个测试项第一个测试项第一个测试项第一个测试项第一个测试项第一个测试项第一个测试项第一个测试项";
    cellModel1.msgColor = [UIColor redColor];
    cellModel1.msgFont = MKFont(20.f);
    cellModel1.textPlaceholder = @"随便搞一下";
    cellModel1.maxLength = 3;
    cellModel1.textFieldType = mk_realNumberOnly;
    cellModel1.textFieldValue = @"2";
    cellModel1.index = 0;
    cellModel1.unit = @"Min";
    cellModel1.unitColor = [UIColor redColor];
    cellModel1.unitFont = MKFont(15.);
    cellModel1.cellType = mk_textFieldCell_normalType;
    cellModel1.textFieldTextColor = [UIColor redColor];
    cellModel1.textFieldTextFont = MKFont(13.f);
    
    cellModel1.noteMsg = @"过来我看一下你到底想显示啥玩意儿啊，不要这么玩行不行啊，和谐和气一点点哦，大家新年过得好吗？开心吗";
    cellModel1.noteMsgColor = [UIColor redColor];
    cellModel1.noteMsgFont = MKFont(14.f);
    
    [self.section0List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.msg = @"第二个测试项";
    cellModel2.textPlaceholder = @"随便搞二下";
    cellModel2.textFieldValue = @"3";
    cellModel2.index = 1;
    cellModel2.cellType = mk_textFieldCell_topLineType;
    
    cellModel2.noteMsg = @"过来我看一下你到底想显示啥玩意儿啊，不要这么玩行不行啊，和谐和气一点点哦，大家新年过得好吗？开心吗,过来我看一下你到底想显示啥玩意儿啊，不要这么玩行不行啊，和谐和气一点点哦，大家新年过得好吗？开心吗";
    
    [self.section0List addObject:cellModel2];
    
    MKTextFieldCellModel *cellModel3 = [[MKTextFieldCellModel alloc] init];
    cellModel3.msg = @"ADV Interval";
    cellModel3.textPlaceholder = @"随便搞3下";
//    cellModel3.maxLength = 3;
    cellModel3.textFieldType = mk_realNumberOnly;
//    cellModel3.textFieldValue = @"2";
    cellModel3.index = 2;
    cellModel3.textAlignment = NSTextAlignmentCenter;
    cellModel3.unit = @"x100ms";
//    cellModel3.borderColor = DEFAULT_TEXT_COLOR;
    cellModel3.cellType = mk_textFieldCell_topLineType;
    [self.section0List addObject:cellModel3];
    
    MKTextFieldCellModel *cellModel4 = [[MKTextFieldCellModel alloc] init];
    cellModel4.msg = @"第4个测试项";
    cellModel4.textPlaceholder = @"随便搞4下";
    cellModel4.maxLength = 10;
    cellModel4.textFieldType = mk_normal;
    cellModel4.textFieldValue = @"2";
    cellModel4.index = 3;
//    cellModel4.clearButtonMode = NO;
//    cellModel4.unit = @"Min";
//    cellModel4.borderColor = DEFAULT_TEXT_COLOR;
    cellModel4.cellType = mk_textFieldCell_normalType;
    [self.section0List addObject:cellModel4];
}

- (void)loadSection1Datas {
    MKTextButtonCellModel *cellModel1 = [[MKTextButtonCellModel alloc] init];
    cellModel1.msg = @"Tracking NotificationTracking NotificationTracking NotificationTracking NotificationTracking NotificationTracking NotificationTracking NotificationTracking NotificationTracking Notification";
    cellModel1.dataList = @[@"Off",@"Light",@"Vibration",@"Light+Vibration"];
    cellModel1.index = 0;
    cellModel1.dataListIndex = 1;
    cellModel1.buttonBackColor = COLOR_WHITE_MACROS;
    cellModel1.buttonTitleColor = UIColorFromRGB(0x2F84D0);
    cellModel1.noteMsg = @"过来我看一下你到底想显示啥玩意儿啊，不要这么玩行不行啊，和谐和气一点点哦，大家新年过得好吗？开心吗";
    [self.section1List addObject:cellModel1];
    
    MKTextButtonCellModel *cellModel2 = [[MKTextButtonCellModel alloc] init];
    cellModel2.msg = @"Tracking";
    cellModel2.msgFont = MKFont(15.f);
    cellModel2.msgColor = [UIColor redColor];
    cellModel2.dataList = @[@"Off",@"Light",@"Vibration",@"Light+Vibration"];
    cellModel2.index = 0;
    cellModel2.dataListIndex = 1;
    cellModel2.buttonBackColor = COLOR_WHITE_MACROS;
    cellModel2.buttonTitleColor = UIColorFromRGB(0x2F84D0);
    cellModel2.buttonLabelFont = MKFont(13.f);
    [self.section1List addObject:cellModel2];
}

- (void)loadSection2Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftMsg = @"新的一种cell";
    cellModel1.rightMsg = @"当前值";
    cellModel1.showRightIcon = YES;
    [self.section2List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"新的一种cell1";
    cellModel2.rightMsg = @"当前值";
    cellModel2.showRightIcon = NO;
    cellModel2.leftMsgTextFont = MKFont(11.f);
    cellModel2.leftMsgTextColor = [UIColor redColor];
    cellModel2.rightMsgTextFont = MKFont(15.f);
    cellModel2.rightMsgTextColor = [UIColor redColor];
    cellModel2.noteMsgFont = MKFont(15.f);
    cellModel2.noteMsgColor = [UIColor redColor];
    [self.section2List addObject:cellModel2];
    
    MKNormalTextCellModel *cellModel3 = [[MKNormalTextCellModel alloc] init];
    cellModel3.leftMsg = @"过来我看一下你到底想显示啥玩意儿啊，不要这么玩行不行啊，和谐和气一点点哦，大家新年过得好吗？开心吗新的一种cell2";
    cellModel3.rightMsg = @"当前值";
    cellModel3.showRightIcon = YES;
    cellModel3.leftIcon = LOADIMAGE(@"slot_frameType", @"png");
    cellModel3.noteMsg = @"过来我看一下你到底想显示啥玩意儿啊，不要这么玩行不行啊，和谐和气一点点哦，大家新年过得好吗？开心吗";
    [self.section2List addObject:cellModel3];
    
    MKNormalTextCellModel *cellModel4 = [[MKNormalTextCellModel alloc] init];
    cellModel4.leftIcon = LOADIMAGE(@"slot_frameType", @"png");
    cellModel4.leftMsg = @"新的一种cell3";
    cellModel4.rightMsg = @"当前值";
    cellModel4.showRightIcon = NO;
    [self.section2List addObject:cellModel4];
}

- (void)loadSection3Datas {
    MKMeasureTxPowerCellModel *cellModel = [[MKMeasureTxPowerCellModel alloc] init];
    cellModel.measurePower = -30;
    cellModel.txPower = mk_deviceTxPowerNeg8dBm;
    [self.section3List addObject:cellModel];
}

- (void)loadSection4Datas {
    MKTextSwitchCellModel *cellModel1 = [[MKTextSwitchCellModel alloc] init];
    cellModel1.leftIcon = LOADIMAGE(@"slot_frameType", @"png");
    cellModel1.msg = @"开关cell1";
    cellModel1.msgColor = [UIColor redColor];
    cellModel1.msgFont = MKFont(12.f);
    cellModel1.isOn = YES;
    cellModel1.switchEnable = NO;
    cellModel1.index = 0;
    [self.section4List addObject:cellModel1];

    MKTextSwitchCellModel *cellModel2 = [[MKTextSwitchCellModel alloc] init];
    cellModel2.msg = @"第二个开关cell";
    cellModel2.leftIcon = LOADICON(@"MKCustomUIModule", @"MKTextSwitchCell", @"mk_MKCustomUIModule_switchSelectedIcon.png");
    cellModel2.isOn = YES;
    cellModel2.index = 1;
    cellModel2.noteMsg = @"阿赫赫尔";
    [self.section4List addObject:cellModel2];
    
    MKTextSwitchCellModel *cellModel3 = [[MKTextSwitchCellModel alloc] init];
    cellModel3.msg = @"开关cell1";
    cellModel3.msgColor = [UIColor yellowColor];
    cellModel3.msgFont = MKFont(18.f);
    cellModel3.isOn = NO;
    cellModel3.index = 2;
    [self.section4List addObject:cellModel3];
}

- (void)loadSection5Datas {
    MKFilterDataCellModel *cellModel1 = [[MKFilterDataCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"MAC Address Filtering";
    cellModel1.isOn = YES;
    cellModel1.selected = YES;
    cellModel1.cellType = mk_filterDataCellType_normal;
    cellModel1.maxLength = 10;
    cellModel1.textFieldType = mk_hexCharOnly;
    cellModel1.textFieldValue = @"aa";
    cellModel1.textFieldPlaceholder = @"MAC Address";
    [self.section5List addObject:cellModel1];
    
    MKFilterDataCellModel *cellModel2 = [[MKFilterDataCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"iBeacon Major Filtering";
    cellModel2.cellType = mk_filterDataCellType_double;
    cellModel2.leftTextFieldValue = @"0";
    cellModel2.rightTextFieldValue = @"10";
    [self.section5List addObject:cellModel2];
}

- (void)loadSubViews {
    self.defaultTitle = @"列表cell测试页面";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(defaultTopInset);
        make.bottom.mas_equalTo(-VirtualHomeHeight);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tableHeaderView = [self tableHeaderView];
        _tableView.tableFooterView = [self tableFooterView];
    }
    return _tableView;
}

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)section1List {
    if (!_section1List) {
        _section1List = [NSMutableArray array];
    }
    return _section1List;
}

- (NSMutableArray *)section2List {
    if (!_section2List) {
        _section2List = [NSMutableArray array];
    }
    return _section2List;
}

- (NSMutableArray *)section3List {
    if (!_section3List) {
        _section3List = [NSMutableArray array];
    }
    return _section3List;
}

- (NSMutableArray *)section4List {
    if (!_section4List) {
        _section4List = [NSMutableArray array];
    }
    return _section4List;
}

- (NSMutableArray *)section5List {
    if (!_section5List) {
        _section5List = [NSMutableArray array];
    }
    return _section5List;
}

- (UIView *)tableHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 60.f)];
    headerView.backgroundColor = RGBCOLOR(237, 243, 250);
    
    MKSearchButton *searchButton = [[MKSearchButton alloc] init];
    searchButton.frame = CGRectMake(15.f, 10.f, kViewWidth - 30, 40.f);
    searchButton.delegate = self;
    MKSearchButtonDataModel *buttonModel = [[MKSearchButtonDataModel alloc] init];
    buttonModel.minSearchRssi = -100;
    searchButton.dataModel = buttonModel;
    [headerView addSubview:searchButton];
    
    return headerView;
}

- (UIView *)tableFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 130.f)];
    footerView.backgroundColor = COLOR_WHITE_MACROS;
    
    UIButton *pushButton = [MKCustomUIAdopter customButtonWithTitle:@"Push"
                                                         titleColor:COLOR_WHITE_MACROS
                                                    backgroundColor:[UIColor redColor]
                                                             target:self
                                                             action:@selector(pushAboutPage)];
    [footerView addSubview:pushButton];
    [pushButton setFrame:CGRectMake(15.f, 30.f, self.view.frame.size.width - 30, 45.f)];
    
    MKSlider *slider = [[MKSlider alloc] initWithFrame:CGRectMake(15, 90, kViewWidth - 30, 30.f)];
    [footerView addSubview:slider];
    
    return footerView;
}

@end
