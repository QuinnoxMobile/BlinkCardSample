/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <React/RCTBridgeDelegate.h>
#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, RCTBridgeDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic,strong) UIViewController * reactNativeViewController;

- (void) goNativeStoryboard:(NSString *)name; // called from the RCTBridge module

- (void) goToReactNative;

@end
