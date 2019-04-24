//
//  ViewController.m
//  RPSystemPickerDemo
//
//  Created by Admin on 2019/4/24.
//  Copyright © 2019 com.personal.project. All rights reserved.
//

#import "ViewController.h"
#import <ReplayKit/ReplayKit.h>

@implementation SingletonClass

+ (SingletonClass*)sharedInstance {
    static SingletonClass* instance = nil;
    if ( !instance ) {
        instance = [[SingletonClass alloc] init];
    }
    
    return instance;
}
@end


@interface ViewController ()

@property (nonatomic, assign) BOOL isBroadcastPickerAppears;
@property (nonatomic, strong) RPSystemBroadcastPickerView *broadcastView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.lightGrayColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(broadcastPickerViewAppears:) name:@"SystemBroadcastPickerAppears" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(broadcastPickerViewDisappears:) name:@"SystemBroadcastPickerDisappears" object:nil];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.center = self.view.center;
    [button addTarget:self action:@selector(sendTouchEventToBroadcastPicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    _broadcastView = [[RPSystemBroadcastPickerView alloc] init];
    //broadcastView.preferredExtension = @"you replaykit extension bundle id";
    [self.view addSubview:_broadcastView];
    
    [self sendTouchEventToBroadcastPicker];
    
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self checkBroadcastPickerShowing];
    }];
}

- (void)broadcastPickerViewAppears:(NSNotification *)noti {
    NSLog(@"Received BroadcastPickerView Appears notification");
    self.isBroadcastPickerAppears = YES;
}

- (void)broadcastPickerViewDisappears:(NSNotification *)noti {
    NSLog(@"receive BroadcastPickerView Disappears notification");
    self.isBroadcastPickerAppears = NO;
}

- (void)checkBroadcastPickerShowing {
    if (self.isBroadcastPickerAppears) {
        NSLog(@"Checking result: BroadcastPickerView Appears");
    } else {
        NSLog(@"Checking result: BroadcastPickerView not appears");
        [[SingletonClass sharedInstance].rpBroadcastPickerStandaloneViewController dismissViewControllerAnimated:NO completion:^{
            [self sendTouchEventToBroadcastPicker];
        }];
    }
}

- (void)sendTouchEventToBroadcastPicker {
    for (UIView *subView in _broadcastView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *broadcastBtn = (UIButton *)subView;
            [broadcastBtn sendActionsForControlEvents:UIControlEventTouchDown];
            break;
        }
    }
}


@end
