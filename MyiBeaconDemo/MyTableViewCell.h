//
//  MyTableViewCell.h
//  MyiBeaconDemo
//
//  Created by 孙宁 on 15/5/21.
//  Copyright (c) 2015年 cnlive. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BRTBeacon;

@interface MyTableViewCell : UITableViewCell

- (void)getDataFromBeacon:(BRTBeacon *)beacon;



@end
