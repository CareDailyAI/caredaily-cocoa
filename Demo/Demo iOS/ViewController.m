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
    [self doSomethingInSwift];
    [self checkVayyarRealmClasses];
}

- (void)initRealm {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [PPRealm configureDefaultRealm];
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

- (void)checkVayyarRealmClasses {
    PPVayyarRoom *room = [PPVayyarRoom initWithDeviceId:@"My Device" data:@{
        @"x_min": @1.9,
        @"x_max": @1.9,
        @"y_min": @0.3,
        @"y_max": @3.9,
        @"z_min": @0,
        @"z_max": @2.5,
    }];

    PPVayyarSubregion *subregion = [PPVayyarSubregion initWithDeviceId:@"My Device" data:@{
        @"subregion_id": @0,
        @"name": @"Bed",
        @"context_id": @1,
        @"x_min_meters": @-1.1,
        @"x_max_meters": @0.83,
        @"y_min_meters": @1.25,
        @"y_max_meters": @3.35,
        @"detect_falls": @false,
        @"detect_presence": @true,
        @"enter_duration_s": @3,
        @"exit_duration_s": @3,
        @"unique_id": @"a7944d3e-f748-4153-8a12-6634fa9bb833"
    }];

    PPVayyarSubregionBehavior *behavior = [PPVayyarSubregionBehavior initWithData:@{
        @"context_id": @2,
        @"title": @"Cal King Bed",
        @"icon": @"bed-alt",
        @"icon_font": @"far",
        @"width_cm": @183,
        @"length_cm": @214,
        @"flexible_cm": @false,
        @"detect_falls": @false,
        @"edit_falls": @false,
        @"detect_presence": @true,
        @"edit_presence": @false,
        @"enter_duration_s": @3,
        @"exit_duration_s": @3,
        @"compatible_behaviors": @[
            @0
        ]
    }];
    [self.realm transactionWithBlock:^{
        [self.realm addOrUpdateObject:room];
        [self.realm addOrUpdateObject:subregion];
        [self.realm deleteObjects:[PPVayyarSubregionBehavior allObjects]];
        [self.realm addObject:behavior];
    }];

    RLMResults<PPVayyarRoom *> *rooms = [PPVayyarRoom allObjects];
    RLMResults *subregions = [PPVayyarSubregion allObjects];
    RLMResults *behaviors = [PPVayyarSubregionBehavior allObjects];
    NSLog(@"%s %@\n%@\n%@", __PRETTY_FUNCTION__, rooms, subregions, behaviors);
    
    PPVayyarRoom *_room = [rooms firstObject];
    NSLog(@"%s name: %@ (%@)", __PRETTY_FUNCTION__, _room.xMin, [_room valueForKey:@"xMin"]);
    
    [self.realm transactionWithBlock:^{
        _room.xMin = @2.0;
    }];
    
    NSLog(@"%s name: %@ (%@)", __PRETTY_FUNCTION__, _room.xMin, [_room valueForKey:@"xMin"]);
}

@end
