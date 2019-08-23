//
//  CalendarManager.m
//  NativeiOSBridgePOC
//
//  Created by Sanjay on 21/08/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "CalendarManager.h"

@implementation CalendarManager

RCT_EXPORT_MODULE();

+ (id)allocWithZone:(NSZone *)zone {
  static CalendarManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [super allocWithZone:zone];
  });
  return sharedInstance;
}


//- (NSArray<NSString *> *)supportedEvents
//{
//  return @[@"EventReminder"];
//}
//
//- (void)calendarEventReminderReceived:(NSNotification *)notification
//{
//  NSString *eventName = notification.userInfo[@"name"];
//  [self sendEventWithName:@"EventReminder" body:@{@"name": eventName}];
//}
- (NSArray<NSString *> *)supportedEvents {
  return @[@"ScanCard"];
}

- (void)tellJS:(NSString *)cardData {
  [self sendEventWithName:@"ScanCard" body:@{@"cardNumber": cardData}];
}

@end
