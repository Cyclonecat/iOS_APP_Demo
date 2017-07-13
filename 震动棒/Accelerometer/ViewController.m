
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface ViewController ()
{
//    SystemSoundID sound;
    NSTimer *shakeTimer;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建震动开始按钮
    UIButton *startBtn_c=[[UIButton alloc]initWithFrame:CGRectMake(180, 200, 100, 44)];
    startBtn_c.backgroundColor=[UIColor blueColor];
    [startBtn_c setTitle:@"嗨起来" forState:UIControlStateNormal];
    [startBtn_c addTarget:self action:@selector(startButton_cClickedAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn_c];
    //创建震动暂停按钮
    UIButton *stopBtn_c=[[UIButton alloc]initWithFrame:CGRectMake(40, 200, 100, 44)];
    stopBtn_c.backgroundColor=[UIColor redColor];
    [stopBtn_c setTitle:@"休息下" forState:UIControlStateNormal];
    [stopBtn_c addTarget:self action:@selector(stopButton_cClickedAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn_c];
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self.motionManager stopGyroUpdates];    
}


-(void)stopButton_cClickedAction{
    //    NSLog(@"stop button action");
//    [audioPlayer stop];
    //陀螺仪
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.gyroUpdateInterval = 0.1;
    
    if ([self.motionManager isGyroAvailable]){
        
        [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue]
                                        withHandler:^(CMGyroData *gyroData, NSError *error) {
                                            
                                            if (error) {
                                                [self.motionManager stopGyroUpdates];
                                            } else {
                                                CMRotationRate rotate = gyroData.rotationRate;
                                                
                                                if ((rotate.x-rotate.y) != 0) {
                                                    AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
                                                    AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
                                                }
                                            }
                                        }];
    }

//    AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
    
//    [self stopAlertSoundWithSoundID:sound];
}

// 停止震动
-(void)stopAlertSoundWithSoundID:(SystemSoundID)sound {
    
    AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
    AudioServicesRemoveSystemSoundCompletion(sound);
}

-(void)startButton_cClickedAction{
    //    NSLog(@"start button action");
    //如果你想震动的提示播放音乐的话就在下面填入你的音乐文件
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"marbach" ofType:@"mp3"];
    //    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &sound);
    //    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL, soundCompleteCallback, NULL);
    
    //陀螺仪
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.gyroUpdateInterval = 0.1;
    
    if ([self.motionManager isGyroAvailable]){
        
        [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue]
                                        withHandler:^(CMGyroData *gyroData, NSError *error) {
                                            
                                            if (error) {
                                                [self.motionManager stopGyroUpdates];
                                            } else {
                                                CMRotationRate rotate = gyroData.rotationRate;
                                                
                                                if ((rotate.x-rotate.y) != 0) {
                                                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                                                }
                                            }
                                        }];
    }

//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//    AudioServicesPlaySystemSound(sound);
    
}

@end
