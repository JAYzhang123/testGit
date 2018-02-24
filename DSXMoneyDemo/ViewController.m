//
//  ViewController.m
//  DSXMoneyDemo
//
//  Created by LQ on 2017/10/25.
//  Copyright © 2017年 ZJ. All rights reserved.
//

#import "ViewController.h"
#import "DSXWalletButton.h"
#import "DSXWalletCellView.h"
#import "UIView+Extension.h"
#import "DSXSendNomalRedpacketViewController.h"
#import "DSXSendLuckRedPacketViewController.h"
#import "testTableViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self)ws = self;
    DSXWalletButton *btn = [[DSXWalletButton alloc] initWithFrame:CGRectMake(10, 10, 180, 45) Click:^{
        testTableViewController *svc = [[testTableViewController alloc] init];
        [ws.navigationController pushViewController:svc animated:YES];
    }];
    [btn setTitle:@"发私聊红包" forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    
    
    DSXWalletButton *btn1 = [[DSXWalletButton alloc] initWithFrame:CGRectMake(210, 10, 180, 45) Click:^{
        DSXSendLuckRedPacketViewController *svc = [[DSXSendLuckRedPacketViewController alloc] init];
        [ws.navigationController pushViewController:svc animated:YES];
    }];
    [btn1 setTitle:@"发手气红包" forState:UIControlStateNormal];
    
    [self.view addSubview:btn1];
    
    
    DSXWalletCellView *walletView = [DSXWalletCellView shareWalletCellViewWithPoint:CGPointMake(50, 100)];
    walletView.isLeftArrow = YES;
    walletView.isEnabled = NO;
    [self.view addSubview:walletView];
    
    DSXWalletCellView *walletView1 = [DSXWalletCellView shareWalletCellViewWithPoint:CGPointMake(100, 200)];
    walletView1.isLeftArrow = NO;
    walletView1.isEnabled = YES;
    [self.view addSubview:walletView1];
    
    [walletView1 addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)click{

    [self.view showAlertWithTitle:nil message:@"弹窗" confirmHandler:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
