
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface ViewController ()
{
//    SystemSoundID sound;
    NSTimer *shakeTimer;
}
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.gyroUpdateInterval = 0.1;
    
    if ([self.motionManager isGyroAvailable]){
        
        [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue]
            withHandler:^(CMGyroData *gyroData, NSError *error) {
            
            if (error) {
                [self.motionManager stopGyroUpdates];
            } else {
                CMRotationRate rotate = gyroData.rotationRate;
                
                NSLog(@"x=%f", rotate.x);
                self.xLabel.text = [NSString stringWithFormat:@"%f", rotate.x];
                self.xBar.progress = ABS(rotate.x);
                
                NSLog(@"y=%f", rotate.y);
                self.yLabel.text = [NSString stringWithFormat:@"%f", rotate.y];
                self.yBar.progress = ABS(rotate.y);
                
                NSLog(@"z=%f", rotate.z);
                self.zLabel.text = [NSString stringWithFormat:@"%f", rotate.z];
                self.zBar.progress = ABS(rotate.z);
            }
        }];
    } else {
        NSLog(@"Gyroscope is not available.");
    }    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self.motionManager stopGyroUpdates];    
}

    
}

@end
