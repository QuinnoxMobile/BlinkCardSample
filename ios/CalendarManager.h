//
//  CalendarManager.h
//  NativeiOSBridgePOC
//
//  Created by Sanjay on 21/08/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTBridgeModule.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalendarManager : RCTEventEmitter <RCTBridgeModule>

-(void)tellJS:(NSMutableArray *)cardData;


@end

NS_ASSUME_NONNULL_END
