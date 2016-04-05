//
//  ViewController.m
//  MyiBeaconDemo
//
//  Created by 孙宁 on 15/4/1.
//  Copyright (c) 2015年 cnlive. All rights reserved.
//

#import "ViewController.h"
#import  "BRTBeaconSDK.h"
#import "MyTableViewCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *_tableView;
    BRTBeaconRegion *_region;
    BRTBeacon *_beacon;
    //NSString *_ProductID;
}
@property(nonatomic,strong)NSString *ProductID;
@end

#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation ViewController
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_beacon disconnectBeacon];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Bright Beacon";
    [self initViews];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)initViews
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight=120;
    [self.view addSubview:_tableView];
    
    UIButton *scanButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    scanButton.frame=CGRectMake(0, 0, 75, 30);
    [scanButton setTitle:@"扫描" forState:UIControlStateNormal];
    [scanButton addTarget:self action:@selector(scanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:scanButton];

    UIButton *endScanButton  =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    endScanButton.frame = CGRectMake(0, 270, 75, 30);
    [endScanButton setTitle:@"结束扫描" forState:UIControlStateNormal];
    [endScanButton addTarget:self action:@selector(endScanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:endScanButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:endScanButton];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cell";
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    BRTBeacon *beacon = [_dataArr objectAtIndex:indexPath.row];
    [cell getDataFromBeacon:beacon];
    cell.backgroundColor=[UIColor blackColor];
        return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self generateProductID];
    UIAlertView *view=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要连接此设备" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    view.delegate = self;
    [view show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            [self ConnectDevicesWithIndex:buttonIndex];

            break;

        default:
            break;
    }
}
- (void)scanBtnClick
{
    [BRTBeaconSDK startRangingBeaconsInRegions:@[[[NSUUID alloc] initWithUUIDString:DEFAULT_UUID]] onCompletion:^(NSArray *beacons, BRTBeaconRegion *region, NSError *error) {
//         NSLog(@"beacons====%@",beacons);
//        for (BRTBeacon * bea in beacons) {
//            NSLog(@"%@", bea.macAddress);
//        }
        _dataArr=[NSMutableArray arrayWithArray:beacons];
        [_tableView reloadData];
    
    }];
   [self createBeaconRegion];
    //仅支持IOS7以上，感知区域中BrightBeacon设备
}
- (void)endScanBtnClick
{
    [BRTBeaconSDK stopRangingBrightBeacons];
}
- (void)createBeaconRegion
{
    if (_region)
        return;
    
    //启动监测区域
   _region = [[BRTBeaconRegion alloc] initWithProximityUUID: [[NSUUID alloc] initWithUUIDString:DEFAULT_UUID] identifier:@"kuuid"];
    _region.notifyOnEntry = YES;
    _region.notifyOnExit = YES;
    _region.notifyEntryStateOnDisplay = YES;
    //范围扫描所有的可见的Bright Beacon设备
    [BRTBeaconSDK startMonitoringForRegions:@[_region]];
    //请求指定区域状态
    [BRTBeaconSDK requestStateForRegions:@[_region]];
    NSLog(@"%@",_region);
}
- (void)ConnectDevicesWithIndex:(NSInteger)index
{
    _beacon = [_dataArr objectAtIndex:index];
    [_beacon connectToBeaconWithCompletion:^(BOOL connected, NSError *error) {
    if (connected) {
        NSLog(@"连接成功");
        [_beacon disconnectBeacon];
    }
    else{
        UIAlertView *view=[[UIAlertView alloc] initWithTitle:@"提示" message:@"设备连接中断" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];
    }
   }];
    //
    //写入数据
    //    NSDictionary *values = @{B_UUID: _beacon.proximityUUID,
    //                             B_MAJOR:_beacon.major,
    //                             B_MINOR:_beacon.minor,
    //                             B_NAME:_beacon.name,
    //                             B_MEASURED:_beacon.measuredPower,
    //                             B_TX:@"0dBm",//发射功率
    //                             B_MODE:@"1",//发布模式,1表示发布，0为不发布
    //                             B_INTERVAL:@"800ms"};//发射间隔
    //    [_beacon writeBeaconValues:values withCompletion:^(NSError *error) {
    //        if(!error){
    //            //写入成功
    //            NSLog(@"写入成功");
    //            
    //        }
    //    }];
}


     


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
