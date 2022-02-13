// ReactNativeSumupsdk.m

// #import "ReactNativeSumupsdk.h"

//
//@implementation ReactNativeSumupsdk
//
//RCT_EXPORT_MODULE()
//
//RCT_EXPORT_METHOD(sampleMethod:(NSString *)stringArgument numberParameter:(nonnull NSNumber *)numberArgument callback:(RCTResponseSenderBlock)callback)
//{
//    // TODO: Implement some actually useful functionality
//    callback(@[[NSString stringWithFormat: @"numberArgument: %@ stringArgument: %@", numberArgument, stringArgument]]);
//}
//
//@end

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNSumupSDK, NSObject)

RCT_EXTERN_METHOD(test:(NSString *)key
                  Resolver:( RCTPromiseResolveBlock) resolve
                  Rejecter:( RCTPromiseRejectBlock) reject)

RCT_EXTERN_METHOD(setupWithKey:(NSString *)key
                  Resolver:( RCTPromiseResolveBlock) resolve
                  Rejecter:( RCTPromiseRejectBlock) reject)

RCT_EXTERN_METHOD(loginWithToken:(NSString *)token
                  Resolver:( RCTPromiseResolveBlock) resolve
                  Rejecter:( RCTPromiseRejectBlock) reject)


RCT_EXTERN_METHOD(setupAndLogin:(NSString *)key
                  Token: (NSString *) token
                  Resolver:( RCTPromiseResolveBlock) resolve
                  Rejecter:( RCTPromiseRejectBlock) reject)

RCT_EXTERN_METHOD(requestPayment: (double ) total
                  Title: (NSString *) title
                  Skip: (BOOL) skip
                  ForeginID: (NSString *) foreginTransactionID
                  Resolver:( RCTPromiseResolveBlock) resolve
                  Rejecter:( RCTPromiseRejectBlock) reject)


@end
