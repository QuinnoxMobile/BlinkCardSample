//
//  CalendarManager.m
//  NativeiOSBridgePOC
//
//  Created by Sanjay on 21/08/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "CardManager.h"

@implementation CardManager

RCT_EXPORT_MODULE();

+ (id)allocWithZone:(NSZone *)zone {
  static CardManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [super allocWithZone:zone];
  });
  return sharedInstance;
}

- (NSArray<NSString *> *)supportedEvents {
  return @[@"ScanCard"];
}

//Calling this method on clicking save card from the viewcontroller.h
- (void)tellJS:(NSMutableArray *)cardData{
  [self sendEventWithName:@"ScanCard" body:@{@"cardNumber": cardData[0],@"validThru":cardData[1],@"cvv":cardData[2]}];
}

@end
