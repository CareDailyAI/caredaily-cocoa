//
//  ViewController.m
//  PeoplepowerDemo
//
//  Created by Destry Teeter on 6/5/20.
//  Copyright © 2020 peoplepowerco. All rights reserved.
//

#import "ViewController.h"

@import Peoplepower;

@interface ViewController ()

@property (nonatomic, strong) RLMRealm *realm;

@property (nonatomic, strong) PPUser *user;
@property (nonatomic, strong) PPLocation *location;

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
    
    
    [self initRealm];
    [self reset];
    [self log:[self check]];
    [self initObjects];
    [self log:[self check]];
    [self reset];
}

- (void)doSomething {
    
}

- (void)initRealm {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.realm = [PPRealm defaultRealm];
}

- (void)initObjects {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.user = [PPUser initWithDictionary:@{@"userId": @(123)}];
    self.location = [PPLocation initWithDictionary:@{@"id": @(123), @"locationId": @(123)}];

    [self.realm transactionWithBlock:^{
        self.user.firstName = @"this";
        self.location.appName = @"my app";
        [self.realm addOrUpdateObject:self.user];
        [self.realm addOrUpdateObject:self.location];
    }];    
}

- (void)reset {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self.realm transactionWithBlock:^{
        [self.realm deleteAllObjects];
    }];
}
    
- (BOOL)check {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    self.user = [PPUser objectForPrimaryKey:@(123)];
    self.location = [PPLocation objectForPrimaryKey:@(123)];
    if (self.user == nil || nil == self.location) {
        return false;
    }
    return true;
}

- (void)log:(BOOL)success {
    NSLog(@"%s: %d", __PRETTY_FUNCTION__, success);
    if (success) {
        NSLog(@"%s Objects:" \
              "\n\nuser\n-id: %@\n-firstName: %@" \
              "\n\nlocation\n-id: %@\n-appName: %@" \
              "\n",
              __PRETTY_FUNCTION__,
              @(self.user.userId), self.user.firstName, @(self.location.locationId), self.location.appName);
    }
    else {
        NSLog(@"%s No Objects", __PRETTY_FUNCTION__);
    }
}

@end
