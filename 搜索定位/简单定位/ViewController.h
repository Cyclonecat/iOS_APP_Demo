//
//  ViewController.h
//  简单定位
//
//  Created by 刘蘩 on 15/12/1.
//  Copyright © 2015年 刘蘩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "mapLocation.h"

@interface ViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtQueryKey;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)geocodeQuery:(id)sender;

@end

