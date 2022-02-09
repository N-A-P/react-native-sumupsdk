// ReactNativeSumupsdk.m

#import "ReactNativeSumupsdk.h"

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
               
                    )
 

@end
