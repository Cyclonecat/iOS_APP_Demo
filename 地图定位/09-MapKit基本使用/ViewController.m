//
//  ViewController.m
//  09-MapKit基本使用
//
//  Created by apple on 14/11/1.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
/*
 *** Terminating app due to uncaught exception 'NSInvalidUnarchiveOperationException', reason: 'Could not instantiate class named MKMapView'

 如果storyboard中用到了地图, 必须手动导入框架
 */

@interface ViewController ()<MKMapViewDelegate>
/**
 *  地图
 */
@property (weak, nonatomic) IBOutlet MKMapView *customMapView;
@property (nonatomic, strong) CLLocationManager *mgr;
/**
 *  地理编码对象
 */
@property (nonatomic ,strong) CLGeocoder *geocoder;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.设置地图显示的类型
    /*
     typedef enum : NSUInteger {
     MKMapTypeStandard , 标准(默认)
     MKMapTypeSatellite ,卫星
     MKMapTypeHybrid 混合(标准 + 卫星)
     } MKMapType;
     */
//    self.customMapView.mapType = MKMapTypeSatellite;
    /*
    CoreLocation框架定位
    CLLocationManager mgr;
    [mgr startUpdatingLocation];
     */
    
    // 注意:在iOS8中, 如果想要追踪用户的位置, 必须自己主动请求隐私权限
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        // 主动请求权限
        self.mgr = [[CLLocationManager alloc] init];
        
        [self.mgr requestAlwaysAuthorization];
    }
    
    // 设置不允许地图旋转
    self.customMapView.rotateEnabled = NO;
    
    // 成为mapVIew的代理
    self.customMapView.delegate = self;
    
    // 如果想利用MapKit获取用户的位置, 可以追踪
    /*
     typedef NS_ENUM(NSInteger, MKUserTrackingMode) {
     MKUserTrackingModeNone = 0, 不追踪/不准确的
     MKUserTrackingModeFollow, 追踪
     MKUserTrackingModeFollowWithHeading, 追踪并且获取用的方向
     }
     */
    self.customMapView.userTrackingMode =  MKUserTrackingModeFollow;
    
    
}

#pragma MKMapViewDelegate
/**
 *  每次更新到用户的位置就会调用(调用不频繁, 只有位置改变才会调用)
 *
 *  @param mapView      促发事件的控件
 *  @param userLocation 大头针模型
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    /*
     地图上蓝色的点就称之为大头针
     大头针可以拥有标题/子标题/位置信息
     大头针上显示什么内容由大头针模型确定(MKUserLocation)
     */
    // 设置大头针显示的内容
//    userLocation.title = @"黑马";
//    userLocation.subtitle = @"牛逼";
    
    // 利用反地理编码获取位置之后设置标题
    [self.geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks firstObject];
        NSLog(@"获取地理位置成功 name = %@ locality = %@", placemark.name, placemark.locality);
        userLocation.title = placemark.name;
        userLocation.subtitle = placemark.locality;
    }];
    
    
    
    // 移动地图到当前用户所在位置
    // 获取用户当前所在位置的经纬度, 并且设置为地图的中心点
//    [self.customMapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    // 设置地图显示的区域
    // 获取用户的位置
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    // 指定经纬度的跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(0.009310,0.007812);
    // 将用户当前的位置作为显示区域的中心点, 并且指定需要显示的跨度范围
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    
    // 设置显示区域
    [self.customMapView setRegion:region animated:YES];
}

/**
 *  地图的区域即将改变时调用

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    NSLog(@"地图的区域即将改变时调用");
}
  */
/**
 *  地图的区域改变完成时调用
 */
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"地图的区域改变完成时调用");
    
    // 0.119170 0.100000
    // 0.238531 0.200156
    // 0.009310 0.007812
    NSLog(@"%f %f", self.customMapView.region.span.latitudeDelta, self.customMapView.region.span.longitudeDelta);
}

#pragma mark - 懒加载
- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}


@end
