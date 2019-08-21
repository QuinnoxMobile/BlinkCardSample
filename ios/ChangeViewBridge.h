//
//  ChangeViewBridge.h
//  NativeiOSBridgePOC
//
//  Created by Sanjay on 19/08/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>


NS_ASSUME_NONNULL_BEGIN

@interface ChangeViewBridge : NSObject<RCTBridgeModule>

- (void) changeToNativeView:(NSString *)name;

@property (nonatomic,assign) NSString * cardNumber;


@end

NS_ASSUME_NONNULL_END
