//
//  ViewController.h
//  Which Hand
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) UILabel *xLabel;
@property (strong, nonatomic) UILabel *yLabel;
@property (strong, nonatomic) UILabel *zLabel;
@property (strong, nonatomic) UIProgressView *xBar;
@property (strong, nonatomic) UIProgressView *yBar;
@property (strong, nonatomic) UIProgressView *zBar;
@property (weak, nonatomic) IBOutlet UILabel *magnitude;

@property (nonatomic, strong) CLLocationManager *locationManager;

@end
