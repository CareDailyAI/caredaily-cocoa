//
//  ViewController.m
//  PeoplepowerDemo
//
//  Created by Destry Teeter on 6/5/20.
//  Copyright © 2020 peoplepowerco. All rights reserved.
//

#import "ViewController.h"
#import "Demo_iOS-Swift.h"

@import Peoplepower;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PPUser *user = [PPUser initWithDictionary:@{}];
    user.firstName = @"this";
    NSLog(@"user.firstName: %@", user.firstName);
    
    PPLocation *location = [PPLocation initWithDictionary:@{}];
    location.appName = @"my app";
    NSLog(@"location.appName: %@", location.appName);
    
    UIButton *button;
    UIImage *image;
    if (@available(iOS 13.0, *)) {
        
        image = [UIImage systemImageNamed:@"circle"
                        withConfiguration: [UIImageSymbolConfiguration configurationWithPointSize:30
                                                                                           weight:UIImageSymbolWeightHeavy
                                                                                            scale:UIImageSymbolScaleLarge]];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = false;
        
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(doSomething) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    [[button.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor] setActive:true];
    [[button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor] setActive:true];
    [[button.widthAnchor constraintEqualToConstant:100] setActive:true];
    [[button.heightAnchor constraintEqualToConstant:100] setActive:true];
}

- (void)doSomething {
    [self doSomethingInSwift];
}


@end
