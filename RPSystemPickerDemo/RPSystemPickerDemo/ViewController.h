//
//  ViewController.h
//  RPSystemPickerDemo
//
//  Created by Admin on 2019/4/24.
//  Copyright © 2019 com.personal.project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingletonClass : NSObject

+ (SingletonClass*)sharedInstance;

@property (assign, nonatomic) UIViewController *rpBroadcastPickerStandaloneViewController;

@end


@interface ViewController : UIViewController


@end

