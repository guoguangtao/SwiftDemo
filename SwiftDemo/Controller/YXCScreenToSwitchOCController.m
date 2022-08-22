//
//  YXCScreenToSwitchOCController.m
//  SwiftDemo
//
//  Created by guogt on 2022/6/2.
//  Copyright © 2022 GGT. All rights reserved.
//

#import "YXCScreenToSwitchOCController.h"
#import "SwiftDemo-Bridging-Header.h"

@interface YXCScreenToSwitchOCController ()

@property (nonatomic, strong) UIButton *portraintButton;
@property (nonatomic, strong) UIButton *landscapeButton;

@end

@implementation YXCScreenToSwitchOCController

/// 刷新UI
- (void)injected {
    
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.whiteColor;
    [self setupUI];
    [self setupConstraints];
}

- (void)dealloc {
    
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions

- (void)buttonClicked:(UIButton *)button {

    [self p_switchScreen:button == self.portraintButton];
}


#pragma mark - Public


#pragma mark - Private

- (void)p_switchScreen:(BOOL)isPortrait {
    NSInteger rotation = isPortrait ? 4 : 2;
    id delegate = UIApplication.sharedApplication.delegate;
    [delegate setValue:@(rotation) forKey:@"allowRotation"];
    [self p_setNewOrientation:isPortrait];
}

- (void)p_setNewOrientation:(BOOL)isPortrait {

    if (isPortrait) {
        NSNumber *resetOrientationTargert = [NSNumber numberWithInteger:UIInterfaceOrientationUnknown];
        [UIDevice.currentDevice setValue:resetOrientationTargert forKey:@"orientation"];
        NSNumber *orientationTarget = [NSNumber numberWithInteger:UIInterfaceOrientationPortrait];
        [UIDevice.currentDevice setValue:orientationTarget forKey:@"orientation"];
    } else {
        NSNumber *resetOrientationTargert = [NSNumber numberWithInteger:UIInterfaceOrientationUnknown];
        [UIDevice.currentDevice setValue:resetOrientationTargert forKey:@"orientation"];
        NSNumber *orientationTarget = [NSNumber numberWithInteger:UIInterfaceOrientationLandscapeRight];
        [UIDevice.currentDevice setValue:orientationTarget forKey:@"orientation"];
    }
}


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {

    self.portraintButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 100, 50)];
    self.portraintButton.backgroundColor = UIColor.orangeColor;
    [self.portraintButton setTitle:@"竖屏" forState:UIControlStateNormal];
    [self.portraintButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.portraintButton];

    self.landscapeButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 170, 100, 50)];
    self.landscapeButton.backgroundColor = UIColor.orangeColor;
    [self.landscapeButton setTitle:@"横屏" forState:UIControlStateNormal];
    [self.landscapeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.landscapeButton];
}


#pragma mark - Constraints

- (void)setupConstraints {


}


#pragma mark - Lazy


@end
