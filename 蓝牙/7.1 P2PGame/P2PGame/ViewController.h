//
//  ViewController.h
//  P2PGame
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
#import <GameKit/GameKit.h>

#define  GAMING 0          //游戏进行中
#define  GAMED  1          //游戏结束

@interface ViewController : UIViewController <GKSessionDelegate, GKPeerPickerControllerDelegate>
{
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UILabel *lblTimer;

@property (weak, nonatomic) IBOutlet UILabel *lblPlayer2;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer1;
@property (weak, nonatomic) IBOutlet UIButton *btnConnect;
@property (weak, nonatomic) IBOutlet UIButton *btnClick;

@property (nonatomic, strong) GKPeerPickerController *picker;
@property (nonatomic, strong) GKSession *session;

- (IBAction)onClick:(id)sender;
- (IBAction)connect:(id)sender;

//清除UI画面上的数据
-(void) clearUI;

//更新计时器
-(void) updateTimer;


@end
