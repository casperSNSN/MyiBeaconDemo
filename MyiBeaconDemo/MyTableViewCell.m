
//
//  MyTableViewCell.m
//  MyiBeaconDemo
//
//  Created by 孙宁 on 15/5/21.
//  Copyright (c) 2015年 cnlive. All rights reserved.
//

#import "MyTableViewCell.h"
#import "BRTBeacon.h"

@interface MyTableViewCell ()

@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *electric;
@property(nonatomic,strong)UILabel *major;
@property(nonatomic,strong)UILabel *minor;
@property(nonatomic,strong)UILabel *mac;
@property(nonatomic,strong)UILabel *distance;//距离手机的距离
@property(nonatomic,strong)UILabel *generateID;

@property (strong) BRTBeacon *beacon;

@end

@implementation MyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}
-(void)initViews
{
    self.name=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 200, 30)];
    self.name.font=[UIFont boldSystemFontOfSize:15];
    self.name.textColor=[UIColor whiteColor];
    [self.contentView addSubview:self.name];

    self.electric=[[UILabel alloc] initWithFrame:CGRectMake(200, 10, 100, 30)];
    self.electric.font=[UIFont boldSystemFontOfSize:15];
    self.electric.textColor=[UIColor whiteColor];
    [self.contentView addSubview:self.electric];
    
    self.major=[[UILabel alloc] initWithFrame:CGRectMake(0, 35, 100, 20)];
    self.major.font=[UIFont systemFontOfSize:12];
    self.major.textColor=[UIColor whiteColor];
    [self.contentView addSubview:self.major];
    
    self.minor=[[UILabel alloc] initWithFrame:CGRectMake(150, 35, 100, 20)];
    self.minor.font=[UIFont systemFontOfSize:12];
    self.minor.textColor=[UIColor whiteColor];
    [self.contentView addSubview:self.minor];
    
    self.mac=[[UILabel alloc] initWithFrame:CGRectMake(0, 55, 200, 20)];
    self.mac.font=[UIFont systemFontOfSize:12];
    self.mac.textColor=[UIColor whiteColor];
    [self.contentView addSubview:self.mac];
    
    self.generateID=[[UILabel alloc] initWithFrame:CGRectMake(200, 55, 100, 20)];
    self.generateID.font=[UIFont systemFontOfSize:12];
    self.generateID.textColor=[UIColor whiteColor];
    [self.contentView addSubview:self.generateID];
    
    self.distance=[[UILabel alloc] initWithFrame:CGRectMake(0, 75, 300, 20)];
    self.distance.font=[UIFont boldSystemFontOfSize:12];
    self.distance.textColor=[UIColor whiteColor];
    [self.contentView addSubview:self.distance];
    
}
- (void)getDataFromBeacon:(BRTBeacon *)beacon
{
    _beacon = beacon;
    [self resetSubViews];
    [self setSubViews];
}
- (void)resetSubViews
{

}
- (void)setSubViews
{
    _name.text=_beacon.name;
    _name.font=[UIFont fontWithName:@"Zapfino" size:12.0];
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    NSString *electric = [numberFormatter stringFromNumber:_beacon.battery];
    _electric.text=[NSString stringWithFormat:@"电量为%@",electric];
    _major.text=[NSString stringWithFormat:@"Major:%@",_beacon.major];
    _minor.text=[NSString stringWithFormat:@"Minor:%@",_beacon.minor];
    _mac.text=[NSString stringWithFormat:@"Mac:%@",_beacon.macAddress];
//    _generateID.text=[NSString stringWithFormat:@"Product:%@",self.ProductID];
    //beacon.distance  SDK
    //[self calcDistByRSSI:beacon.rssi] My algorithm
    _distance.text=[NSString stringWithFormat:@"设备距离当前手机的距离为%f米",[self calcDistByRSSI:_beacon.rssi]];
    
}

/*
 计算公式：d = 10^((abs(RSSI) - A) / (10 * n))
 
 d - 计算所得距离
 
 
 RSSI - 接收信号强度（负值）
 
 A - 发射端和接收端相隔1米时的信号强度，最佳范围为45—49
 
 n - 环境衰减因子，最佳范围为3.25—4.5
 */
- (float)calcDistByRSSI:(int)rssi
{
    int iRssi = abs(rssi);
    float power = (iRssi-59)/(10*2.0);//传入RSSI值，返回距离（单位：米）。
    return pow(10, power);
}
-(void)generateProductID
{
    int num1 = arc4random() % 10;
    int num2 = arc4random() % 10;
    int num3 = arc4random() % 10;
    int num4 = arc4random() % 10;
    int num5 = arc4random() % 10;
//    self.ProductID = [NSString stringWithFormat:@"%d%d%d%d%d",num1,num2,num3,num4,num5];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
