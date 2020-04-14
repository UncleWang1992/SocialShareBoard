//
//  ViewController.m
//  WSGShareBoard
//
//  Created by 王双贵 on 2020/4/14.
//  Copyright © 2020 王双贵. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "ShareView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubView];
}

- (void)createSubView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"分享" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(shareBoardBySelfDefined) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.offset(80);
        make.height.offset(30);
    }];
}

- (void)shareBoardBySelfDefined {
    BOOL hadInstalledWeixin = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
    BOOL hadInstalledQQ = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
    BOOL hasSinaWeibo = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weibo://"]];
    
    NSMutableArray *titlearr     = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *imageArr     = [NSMutableArray arrayWithCapacity:5];
    NSMutableArray *typeArr     = [NSMutableArray arrayWithCapacity:5];
    
    [titlearr addObjectsFromArray:@[@"钉钉"]];
    [imageArr addObjectsFromArray:@[@"dingding"]];
    [typeArr addObject:@(ShareTypeDingTalk)];
    
    if (!hadInstalledWeixin) {
        [titlearr addObjectsFromArray:@[@"微信", @"微信朋友圈"]];
        [imageArr addObjectsFromArray:@[@"weichat",@"weichatLine"]];
        [typeArr addObjectsFromArray:@[@(ShareTypeWechatSession), @(ShareTypeWechatTimeLine)]];
    }
    
    if (!hadInstalledQQ) {
        [titlearr addObjectsFromArray:@[@"QQ", @"QQ空间"]];
        [imageArr addObjectsFromArray:@[@"qq",@"qqzone"]];
        [typeArr addObjectsFromArray:@[@(ShareTypeQQ), @(ShareTypeQZone)]];
    }

    
    if (!hasSinaWeibo) {
        [titlearr addObjectsFromArray:@[@"微博"]];
        [imageArr addObjectsFromArray:@[@"weibo"]];
        [typeArr addObject:@(ShareTypeSina)];
    }
    
    [titlearr addObjectsFromArray:@[@"短信"]];
    [imageArr addObjectsFromArray:@[@"sms"]];
    [typeArr addObject:@(ShareTypeSMS)];
    
    ShareView *shareView = [[ShareView alloc] initWithShareHeadOprationWith:titlearr andImageArry:imageArr andProTitle:@"分享到"];
    [shareView setBtnClick:^(NSInteger btnTag) {
        NSLog(@"\n点击第几个====%d\n当前选中的按钮title====%@",(int)btnTag,titlearr[btnTag]);
        [self shareToPlatform:[typeArr[btnTag] integerValue]];
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
}

- (void)shareToPlatform:(ShareType)type {
    switch (type) {
        case ShareTypeDingTalk:
            NSLog(@"分享至钉钉");
            break;
        case ShareTypeWechatSession:
            NSLog(@"分享至微信");
            break;
        case ShareTypeWechatTimeLine:
            NSLog(@"分享至朋友圈");
            break;
        case ShareTypeQQ:
            NSLog(@"分享至QQ");
            break;
        case ShareTypeQZone:
            NSLog(@"分享至QQ空间");
            break;
        case ShareTypeSina:
            NSLog(@"分享至微博");
            break;
        case ShareTypeSMS:
            NSLog(@"分享至短信");
            break;
        default:
            break;
    }
}

@end
