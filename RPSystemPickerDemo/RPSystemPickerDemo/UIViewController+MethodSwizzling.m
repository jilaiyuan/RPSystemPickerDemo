//
//  UIViewController+MethodSwizzling.m
//  RPSystemPickerDemo
//
//  Created by Admin on 2019/4/23.
//  Copyright © 2019 com.mypersonal.project.demo. All rights reserved.
//

#import "UIViewController+MethodSwizzling.h"
#import <objc/runtime.h>
#import "ViewController.h"

@implementation UIViewController (MethodSwizzling)

+ (void)load {
    Method init = class_getInstanceMethod([self class], @selector(init));
    Method _init = class_getInstanceMethod([self class], @selector(_init));
    method_exchangeImplementations(init, _init);
    
    Method viewDidLoad = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method _viewDidLoad = class_getInstanceMethod([self class], @selector(_viewDidLoad));
    method_exchangeImplementations(viewDidLoad, _viewDidLoad);
    
    Method viewWillDisappear = class_getInstanceMethod([self class], @selector(viewWillDisappear:));
    Method _viewWillDisappear = class_getInstanceMethod([self class], @selector(_viewWillDisappear:));
    method_exchangeImplementations(viewWillDisappear, _viewWillDisappear);
}

- (instancetype)_init {
    id obj = [self _init];
    
    @try {
        Class cls = NSClassFromString(@"RPBroadcastPickerStandaloneViewController");
        if ([self isKindOfClass:cls]) {
            NSLog(@"RPBroadcastPickerStandaloneViewController init");
            [SingletonClass sharedInstance].rpBroadcastPickerStandaloneViewController = obj;
        }
    } @catch (NSException *exception) {
    }
    
    return obj;
}

- (void)_viewDidLoad {
    [self _viewDidLoad];
    
    @try {
        Class cls = NSClassFromString(@"RPBroadcastPickerHostViewController");
        if ([self isKindOfClass:cls]) {
            NSLog(@"RPBroadcastPickerHostViewController viewdidLoad: broadcast picker will appears");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SystemBroadcastPickerAppears" object:nil];
        }
    } @catch (NSException *exception) {
    }
}

- (void)_viewWillDisappear:(BOOL)animated
{
    [self _viewWillDisappear:animated];
    
    @try {
        Class cls = NSClassFromString(@"RPBroadcastPickerHostViewController");
        if ([self isKindOfClass:cls]) {
            NSLog(@"RPBroadcastPickerHostViewController viewWillDisappear: broadcast picker will dismiss");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SystemBroadcastPickerDisappears" object:nil];
        }
    } @catch (NSException *exception) {
    }
}

@end
