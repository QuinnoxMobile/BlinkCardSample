//
//  ChangeViewBridge.m
//  NativeiOSBridgePOC
//
//  Created by Sanjay on 19/08/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "ChangeViewBridge.h"
#import <React/RCTLog.h>
#import "NativeiOSBridgePOC/AppDelegate.h"
#import <React/RCTEventEmitter.h>

@implementation ChangeViewBridge

RCT_EXPORT_MODULE(ChangeViewBridge);

RCT_EXPORT_METHOD(changeToNativeView:(NSString *)name) {
  NSLog(@"RN binding - Native View - Loading ViewController");
  
  dispatch_async(dispatch_get_main_queue(), ^(void) {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate goNativeStoryboard:name];
  });
  
}

//RCT_EXPORT_METHOD(getDeviceName:(RCTResponseSenderBlock)callback){
//  @try{
//    callback(@[[NSNull null], _cardNumber]);
//    NSLog(@"%@", _cardNumber);
//  }
//  @catch(NSException *exception){
//    callback(@[exception.reason, [NSNull null]]);
//  }
//}

//RCT_EXPORT_METHOD(getDeviceName:(RCTResponseSenderBlock)callback){
//  @try{
//    NSString *deviceName = [[UIDevice currentDevice] name];
//    callback(@[[NSNull null], deviceName]);
//  }
//  @catch(NSException *exception){
//    callback(@[exception.reason, [NSNull null]]);
//  }
//}

//RCT_EXPORT_METHOD(getEmployeeList:(RCTResponseSenderBlock)callback)
//{
////  NSArray *employeeList =  
////  callback(@[[NSNull null], employeeList]);
//}

@end
