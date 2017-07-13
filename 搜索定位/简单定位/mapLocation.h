//
//  mapLocation.h
//  简单定位
//
//  Created by 刘蘩 on 15/12/1.
//  Copyright © 2015年 刘蘩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface mapLocation : NSObject<MKAnnotation>

// 地图标点类必须实现 MKAnnotation 协议
// 地理坐标
@property (nonatomic ,readwrite) CLLocationCoordinate2D coordinate ;

//街道属性信息
@property (nonatomic , copy) NSString * streetAddress ;

// 城市信息属性
@property (nonatomic ,copy) NSString * city ;

// 州，省 市 信息

@property(nonatomic ,copy ) NSString * state ;
//邮编
@property (nonatomic ,copy) NSString * zip  ;


@end