//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"

#if __has_include(<device_info/FLTDeviceInfoPlugin.h>)
#import <device_info/FLTDeviceInfoPlugin.h>
#else
@import device_info;
#endif

#if __has_include(<flutter_secure_storage/FlutterSecureStoragePlugin.h>)
#import <flutter_secure_storage/FlutterSecureStoragePlugin.h>
#else
@import flutter_secure_storage;
#endif

#if __has_include(<path_provider/FLTPathProviderPlugin.h>)
#import <path_provider/FLTPathProviderPlugin.h>
#else
@import path_provider;
#endif

#if __has_include(<vibration/VibrationPlugin.h>)
#import <vibration/VibrationPlugin.h>
#else
@import vibration;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTDeviceInfoPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTDeviceInfoPlugin"]];
  [FlutterSecureStoragePlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterSecureStoragePlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [VibrationPlugin registerWithRegistrar:[registry registrarForPlugin:@"VibrationPlugin"]];
}

@end
