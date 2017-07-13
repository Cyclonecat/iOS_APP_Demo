//
//  ViewController.m
//  打光板
//
//  Created by 刘蘩 on 16/3/21.
//  Copyright © 2016年 刘蘩. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic) CGFloat brightness NS_AVAILABLE_IOS(5_0);

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    float value = [UIScreen mainScreen].brightness;
//    
//    [[UIScreen mainScreen] setBrightness:value];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


UISlider* volumeViewSlider;
float systemLight;//系统值
CGPoint startPoint;//起始位置

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(event.allTouches.count == 1){
        //保存当前触摸的位置
        CGPoint point = [[touches anyObject] locationInView:self.view];
        startPoint = point;
    }
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if(event.allTouches.count == 1){
        //计算位移
        CGPoint point = [[touches anyObject] locationInView:self.view];
//        float dx = point.x - startPoint.x;
        float dy = point.y - startPoint.y;
        int index = (int)dy;
        if(index>0){
            if(index%1==0){//每10个像素声音减一格

                if(systemLight>0.1){
                    systemLight = systemLight-0.05;

                    [[UIScreen mainScreen] setBrightness:systemLight];
                    [volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
                }
            }
        }else{
            if(index%1==0){//每10个像素声音增加一格
                
                if(systemLight>=0 && systemLight<1){
                    systemLight = systemLight+0.05;

                    [[UIScreen mainScreen] setBrightness:systemLight];

                    [volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
                }
            }
        }
    }
}



@end
