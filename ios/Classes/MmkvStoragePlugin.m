#import "MmkvStoragePlugin.h"
#if __has_include(<mmkv_storage/mmkv_storage-Swift.h>)
#import <mmkv_storage/mmkv_storage-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "mmkv_storage-Swift.h"
#endif

@implementation MmkvStoragePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMmkvStoragePlugin registerWithRegistrar:registrar];
}
@end
