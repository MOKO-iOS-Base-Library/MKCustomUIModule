//
//  MKCellTestController.m
//  MKCustomUIModule_Example
//
//  Created by aa on 2021/1/8.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKCellTestController.h"

#import <MKBaseModuleLibrary/MKMacroDefines.h>
#import <MKBaseModuleLibrary/MKBaseTableView.h>

#import <Masonry/Masonry.h>
#import <MLInputDodger/MLInputDodger.h>

#import "MKCustomUIAdopter.h"

#import "MKNormalSliderCell.h"
#import "MKLoRaAdvancedSettingCell.h"
#import "MKLoRaSettingCHCell.h"
#import "MKMixedChoiceCell.h"
#import "MKRawAdvDataOperationCell.h"
#import "MKFilterRawAdvDataCell.h"

@interface MKCellTestController ()<UITableViewDelegate,
UITableViewDataSource,
MKNormalSliderCellDelegate,
MKLoRaAdvancedSettingCellDelegate,
MKLoRaSettingCHCellDelegate,
MKMixedChoiceCellDelegate,
MKRawAdvDataOperationCellDelegate,
MKFilterRawAdvDataCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *sectionHeaderList;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)NSMutableArray *section5List;

@end

@implementation MKCellTestController

- (void)dealloc {
    NSLog(@"MKCellTestController销毁");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
    //本页面禁止右划退出手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKNormalSliderCellModel *model = self.section0List[indexPath.row];
        return [model cellHeightWithContentWidth:kViewWidth];
    }
    if (indexPath.section == 1) {
        return 80.f;
    }
    if (indexPath.section == 2) {
        MKLoRaSettingCHCellModel *model = self.section2List[indexPath.row];
        return [model cellHeightWithContentWidth:kViewWidth];
    }
    if (indexPath.section == 3) {
        MKMixedChoiceCellModel *model = self.section3List[indexPath.row];
        return [model cellHeightWithContentWidth:kViewWidth];
    }
    if (indexPath.section == 4) {
        return 80.f;
    }
    if (indexPath.section == 5) {
        return 95.f;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 70.f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionHeaderList[section];
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
        MKNormalSliderCell *cell = [MKNormalSliderCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        MKLoRaAdvancedSettingCell *cell = [MKLoRaAdvancedSettingCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 2) {
        MKLoRaSettingCHCell *cell = [MKLoRaSettingCHCell initCellWithTableView:tableView];
        cell.delegate = self;
        cell.dataModel = self.section2List[indexPath.row];
        return cell;
    }
    if (indexPath.section == 3) {
        MKMixedChoiceCell *cell = [MKMixedChoiceCell initCellWithTableView:tableView];
        cell.dataModel = self.section3List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 4) {
        MKRawAdvDataOperationCell *cell = [MKRawAdvDataOperationCell initCellWithTableView:tableView];
        cell.dataModel = self.section4List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKFilterRawAdvDataCell *cell = [MKFilterRawAdvDataCell initCellWithTableView:tableView];
    cell.dataModel = self.section5List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKNormalSliderCellDelegate
- (void)mk_normalSliderValueChanged:(NSInteger)value index:(NSInteger)index {
    NSLog(@"当前滑竿值变了:%@---%@",@(value),@(index));
}

#pragma mark - MKLoRaAdvancedSettingCellDelegate
- (void)mk_loraSetting_advanceCell_switchStatusChanged:(BOOL)isOn {
    NSLog(@"开关至发生改变了 :%@",@(isOn));
}

#pragma mark - MKLoRaSettingCHCellDelegate
- (void)mk_loraSetting_chLowValueChanged:(NSString *)value chLowIndex:(NSInteger)chLowIndex cellIndex:(NSInteger)index {
    NSLog(@"低位值改变:%@++++++++%@+++++++++%@",value,@(chLowIndex),@(index));
}

- (void)mk_loraSetting_chHighValueChanged:(NSString *)value chHighIndex:(NSInteger)chHighIndex cellIndex:(NSInteger)index {
    NSLog(@"高位值改变:%@++++++++%@+++++++++%@",value,@(chHighIndex),@(index));
}

#pragma mark - MKMixedChoiceCellDelegate
- (void)mk_mixedChoiceSubButtonEventMethod:(BOOL)selected cellIndex:(NSInteger)cellIndex buttonIndex:(NSInteger)buttonIndex {
    NSLog(@"多选cell状态值发生改变了:%@----%@-%@",@(selected),@(cellIndex),@(buttonIndex));
}

#pragma mark - MKRawAdvDataOperationCellDelegate

/// +号按钮点击事件
- (void)mk_rawAdvDataOperation_addMethod {
    MKFilterRawAdvDataCellModel *cellModel = [[MKFilterRawAdvDataCellModel alloc] init];
    cellModel.rawDataMaxBytes = 2;
    cellModel.dataTypePlaceHolder = @"00-FF";
    cellModel.minTextFieldPlaceHolder = @"00-BB";
    cellModel.maxTextFieldPlaceHolder = @"00-AA";
    cellModel.rawTextFieldPlaceHolder = @"11-FF";
    cellModel.index = self.section5List.count;
    [self.section5List addObject:cellModel];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
}

/// -号按钮点击事件
- (void)mk_rawAdvDataOperation_subMethod {
    if (self.section5List.count == 0) {
        return;
    }
    [self.section5List removeLastObject];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
}

/// 开关状态发生改变
/// @param isOn YES:打开，NO:关闭
- (void)mk_rawAdvDataOperation_switchStatusChanged:(BOOL)isOn {
    NSLog(@"过滤数据的那个开关发生改变了:%@",@(isOn));
}

/// 白名单按钮点击事件
/// @param selected YES:选中,NO:未选中
- (void)mk_rawAdvDataOperation_whiteListButtonSelected:(BOOL)selected {
    NSLog(@"过滤数据的那个白名单按钮发送改变了:%@",@(selected));
}

#pragma mark - MKFilterRawAdvDataCellDelegate
/// 输入框内容发生改变
/// @param textType 哪个输入框发生改变了
/// @param index 当前cell所在的row
/// @param textValue 当前textField内容
- (void)rawFilterDataChanged:(mk_filterRawAdvDataTextType)textType
                       index:(NSInteger)index
                   textValue:(NSString *)textValue {
    NSLog(@"过滤原始数据的输入框发生改变:输入框类型%@------当前cell索引%@------输入框内容%@",@(textType),@(index),textValue);
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    [self loadSection4Datas];
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKNormalSliderCellModel *cellModel1 = [[MKNormalSliderCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = [MKCustomUIAdopter attributedString:@[@"偶来亿啊接收到 "] fonts:@[MKFont(15.f)] colors:@[DEFAULT_TEXT_COLOR]];
    cellModel1.sliderMaxValue = 0;
    cellModel1.sliderMinValue = -100;
    cellModel1.noteMsg = @"测试一下带滑竿的cell,测试一下带滑竿的cell测试一下带滑竿的cell测试一下带滑竿的cell测试一下带滑竿的cell测试一下带滑竿的cell测试一下带滑竿的cell测试一下带滑竿的cell测试一下带滑竿的cell测试一下带滑竿的cell测试一下带滑竿的cell测试一下带滑竿的cell";
    [self.section0List addObject:cellModel1];
    
    MKNormalSliderCellModel *cellModel2 = [[MKNormalSliderCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = [MKCustomUIAdopter attributedString:@[@"Valid BLE Data Filter Interval",@"   (1-600s)"] fonts:@[MKFont(20.f),MKFont(15.f)] colors:@[DEFAULT_TEXT_COLOR,RGBCOLOR(102, 102, 102)]];
    cellModel2.sliderMaxValue = 600;
    cellModel2.sliderMinValue = 1;
    cellModel2.sliderValue = 100;
    cellModel2.unit = @"s";
    cellModel2.changed = YES;
    cellModel2.leftNoteMsg = @"*The device will store the Contact Tracking  data every";
    cellModel2.rightNoteMsg = @"and the same MAC address only be saved one time.";
    [self.section0List addObject:cellModel2];
    
    MKNormalSliderCellModel *cellModel3 = [[MKNormalSliderCellModel alloc] init];
    cellModel3.index = 2;
    cellModel3.msg = [MKCustomUIAdopter attributedString:@[@"Alarm Trigger RSSI",@"      -127-0dBm"] fonts:@[MKFont(20.f),MKFont(15.f)] colors:@[DEFAULT_TEXT_COLOR,RGBCOLOR(102, 102, 102)]];
    cellModel3.sliderMaxValue = 0;
    cellModel3.sliderMinValue = -127;
    cellModel3.sliderValue = -20;
    cellModel3.changed = YES;
    cellModel3.leftNoteMsg = @"*The device alarm  is triggered when the BLE RSSI scanned is greater than";
    cellModel3.rightNoteMsg = @".";
    [self.section0List addObject:cellModel3];
}

- (void)loadSection1Datas {
    MKLoRaAdvancedSettingCellModel *dataModel = [[MKLoRaAdvancedSettingCellModel alloc] init];
    [self.section1List addObject:dataModel];
}

- (void)loadSection2Datas {
    MKLoRaSettingCHCellModel *cellModel1 = [[MKLoRaSettingCHCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.chHighBackColor = [UIColor redColor];
    cellModel1.chHighValueList = @[@"1",@"ehhe",@"asdf"];
    cellModel1.chHighIndex = 1;
    cellModel1.chHighButtonEnable = NO;
    cellModel1.chLowBackColor = [UIColor yellowColor];
    cellModel1.chLowValueList = @[@"ok",@"come"];
    cellModel1.chLowIndex = 1;
    cellModel1.msg = @"第一个测试一下阿霞阿斯顿发送到发送啊啥的看法就是大幅拉升客户方";
    cellModel1.msgFont = MKFont(20.f);
    cellModel1.msgColor = [UIColor blueColor];
    cellModel1.noteMsg = @"adfadfasdfasdfasdfasdfasdfasfdasdfasdfasfdasfasfdasdfasfdasdfsadfasdfasfdasfd";
    cellModel1.noteMsgFont = MKFont(13.f);
    cellModel1.noteMsgColor = DEFAULT_TEXT_COLOR;
    [self.section2List addObject:cellModel1];
    
    MKLoRaSettingCHCellModel *cellModel2 = [[MKLoRaSettingCHCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"CH";
    cellModel2.chLowValueList = @[@"0",@"1",@"2"];
    cellModel2.chHighValueList = @[@"3",@"4",@"5"];
    cellModel2.noteMsg = @"*It is only used for US915,AU915,CN470";
    [self.section2List addObject:cellModel2];
}

- (void)loadSection3Datas {
    MKMixedChoiceCellModel *cellModel1 = [[MKMixedChoiceCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"你这个需求快吓死我了，咋这么变态的需求啊";
    cellModel1.msgColor = [UIColor redColor];
    cellModel1.msgFont = MKFont(20.f);
    cellModel1.noteMsg = @"那我这下子就知道你到底想干啥了，你个憨扑街，再这样玩会被打死的";
    cellModel1.noteMsgFont = MKFont(14.f);
    cellModel1.noteMsgColor = [UIColor yellowColor];
    cellModel1.leftIcon = LOADICON(@"MKCustomUIModule", @"MKMixedChoiceCell", @"mk_customUI_wifisignalIcon.png");
    MKMixedChoiceCellButtonModel *buttonModel1 = [[MKMixedChoiceCellButtonModel alloc] init];
    buttonModel1.buttonIndex = 0;
    buttonModel1.selected = YES;
    buttonModel1.buttonMsg = @"选择一下第一个的按钮开关吧";
    buttonModel1.buttonMsgFont = MKFont(13.f);
    buttonModel1.buttonMsgColor = [UIColor redColor];
    
    MKMixedChoiceCellButtonModel *buttonModel2 = [[MKMixedChoiceCellButtonModel alloc] init];
    buttonModel2.buttonIndex = 1;
    buttonModel2.buttonMsg = @"选择2下第2个的按钮开关吧";
    buttonModel2.selectedIcon = LOADIMAGE(@"slot_frameType", @"png");
    
    MKMixedChoiceCellButtonModel *buttonModel3 = [[MKMixedChoiceCellButtonModel alloc] init];
    buttonModel3.buttonIndex = 2;
    buttonModel3.buttonMsg = @"选择2下第2个的按钮开关吧选择2下第2个的按钮开关吧选择2下第2个的按钮开关吧选择2下第2个的按钮开关吧选择2下第2个的按钮开关吧选择2下第2个的按钮开关吧";
    buttonModel3.selectedIcon = LOADICON(@"MKCustomUIModule", @"MKMixedChoiceCell", @"mk_customUI_wifisignalIcon.png");
    
    MKMixedChoiceCellButtonModel *buttonModel4 = [[MKMixedChoiceCellButtonModel alloc] init];
    buttonModel4.buttonIndex = 3;
    buttonModel4.buttonMsg = @"选择23下第2个的按钮开关吧选择2下第4234asdf2个的按钮开关吧选择2下第2个的按钮开关吧选择2下第2个的按钮开关吧选择2下第2个的按钮开关吧选择2下第2个的按钮开关吧";
    cellModel1.dataList = @[buttonModel1,buttonModel2,buttonModel3,buttonModel4];
    
    [self.section3List addObject:cellModel1];
    
    
    MKMixedChoiceCellModel *cellModel2 = [[MKMixedChoiceCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"你这个需求快吓死我了，咋这么变态的需求啊";
    MKMixedChoiceCellButtonModel *buttonModel5 = [[MKMixedChoiceCellButtonModel alloc] init];
    buttonModel5.buttonIndex = 0;
    buttonModel5.selected = YES;
    buttonModel5.buttonMsg = @"选择一下第一个的按钮开关吧";
    
    MKMixedChoiceCellButtonModel *buttonModel6 = [[MKMixedChoiceCellButtonModel alloc] init];
    buttonModel6.buttonIndex = 1;
    buttonModel6.buttonMsg = @"选择2下第2个的按钮开关吧";
    cellModel2.dataList = @[buttonModel5,buttonModel6,buttonModel1];
    [self.section3List addObject:cellModel2];
}

- (void)loadSection4Datas {
    MKRawAdvDataOperationCellModel *cellModel = [[MKRawAdvDataOperationCellModel alloc] init];
    cellModel.isOn = YES;
    cellModel.selected = YES;
    cellModel.msg = @"Filter by Raw Adv Data";
    [self.section4List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"测试";
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
    }
    return _tableView;
}

- (NSMutableArray *)sectionHeaderList {
    if (!_sectionHeaderList) {
        _sectionHeaderList = [NSMutableArray array];
        
        [_sectionHeaderList addObjectsFromArray:@[@"MKNormalSliderCell",@"MKLoRaAdvancedSettingCell",@"MKLoRaSettingCHCell",@"MKMixedChoiceCell",@"MKRawAdvDataOperationCell",@"MKFilterRawAdvDataCell"]];
    }
    return _sectionHeaderList;
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

@end
