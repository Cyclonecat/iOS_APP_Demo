//
//  ViewController.m
//  扫一扫
//
//  Created by 刘蘩 on 15/11/18.
//  Copyright © 2015年 刘蘩. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _isReading = NO;
    
    // 背景
    self.view.backgroundColor = [UIColor grayColor];
    
    // 扫描按钮
    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [scanButton setTitle:@"取消" forState:UIControlStateNormal];
    scanButton.frame = CGRectMake(130, 480, 120, 40);
    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [scanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scanButton setFont:[UIFont systemFontOfSize:20]];
    [self.view addSubview:scanButton];
    
//    UIButton * startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [startButton setTitle:@"START" forState:UIControlStateNormal];
//    startButton.frame = CGRectMake(130, 520, 120, 40);
//    [startButton addTarget:self action:@selector(setupCamera) forControlEvents:UIControlEventTouchUpInside];
//    [startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [startButton setFont:[UIFont systemFontOfSize:20]];
//    [self.view addSubview:startButton];
    
    UILabel *labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(50, 70, 290, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
    [self.view addSubview:labIntroudction];
    
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 146, 300, 300)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(75, 148, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(75, 150+2*num, 220, 2);
        if (2*num == 280) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(75, 150+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}

-(void)backAction
{
    
//    NSLog(@"backAction");
    
    [self dismissViewControllerAnimated:YES completion:^{
        [timer invalidate];
    }];
    
    [self stopReading];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self setupCamera];
}

- (void)setupCamera
{

    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =CGRectMake(40, 146, 300, 300);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    // Start
    [_session startRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        //判断回传的数据类型
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
    
//    [_session stopRunning];
    
    [self dismissViewControllerAnimated:YES completion:^
     {
         [timer invalidate];
     }];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:stringValue]];
 
    }
    _isReading = NO;
}

- (void)startReading{
    if (!_isReading) {
        [self startReading];
    }
    else{
        [self stopReading];
    }
    _isReading = !_isReading;
}


-(void)stopReading{
    [_session stopRunning];
     _session = nil;
    
    [_preview removeFromSuperlayer];
//    [_line removeFromSuperview];
//    [self performSelectorOnMainThread:@selector(setupCamera) withObject:nil waitUntilDone:NO];
    [self setupCamera];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end