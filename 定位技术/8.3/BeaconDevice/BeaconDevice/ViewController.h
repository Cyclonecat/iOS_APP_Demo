//
//  ViewController.h
//  BeaconDevice
//
//  Created by 关东升 on 12-9-24.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define kUUID @"AF56BA9A-A3CD-4FA2-8908-84343271439E"
#define kID @"com.51work6.AirLocate"
#define kPower  @-59

@interface ViewController : UIViewController <CBPeripheralManagerDelegate>

@property (strong, nonatomic) CBPeripheralManager  *peripheralManager;

- (IBAction)valueChanged:(id)sender;

@end
