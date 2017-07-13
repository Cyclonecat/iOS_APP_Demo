//
//  ViewController.m
//  Which Hand
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self prefersStatusBarHidden];
    
    _locationManager = [[CLLocationManager alloc] init];
	_locationManager.delegate = self;
    
	if( [CLLocationManager headingAvailable])
	{
		[_locationManager startUpdatingHeading];
	} else {
		NSLog(@"磁力计不可用。");
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [_locationManager stopUpdatingHeading];
    _locationManager.delegate = nil;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)heading {
    
    self.xLabel.text = [NSString stringWithFormat:@"%.2f", heading.x];
    self.xBar.progress = ABS(heading.x/100);
    
    self.yLabel.text = [NSString stringWithFormat:@"%.2f", heading.y];
    self.yBar.progress = ABS(heading.y/100);
    
    self.zLabel.text = [NSString stringWithFormat:@"%.2f", heading.z];
    self.zBar.progress = ABS(heading.z/100);
    
    CGFloat magnitude = sqrt(heading.x*heading.x + heading.y*heading.y + heading.z*heading.z);
    self.magnitude.text = [NSString stringWithFormat:@"%.2f", magnitude];
    
    NSLog(@"magnitude = %f",magnitude);
    if (magnitude >= 150) {
        [self vibrate];
    }
    
}


//手机震动
- (void)vibrate
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
