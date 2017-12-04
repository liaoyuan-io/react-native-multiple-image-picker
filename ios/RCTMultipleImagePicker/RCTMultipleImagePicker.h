//
//  RCTMultipleImagePicker.h
//  RCTMultipleImagePicker
//
//  Created by ShenTong on 16/6/20.
//
//

#import <Foundation/Foundation.h>
#if __has_include("RCTBridgeModule.h")
    #import "RCTBridgeModule.h"
    #import "RCTConvert.h"
#else
    #import <React/RCTBridgeModule.h>
    #import <React/RCTConvert.h>
#endif
#import "TZImagePickerController.h"


@interface RCTMultipleImagePicker : NSObject <RCTBridgeModule, TZImagePickerControllerDelegate>

@property (nonatomic, strong) RCTPromiseResolveBlock resolve;
@property (nonatomic, strong) RCTPromiseRejectBlock reject;

@property (nonatomic, strong) NSMutableDictionary *assetsFromPath;
@property (nonatomic, strong) NSMutableDictionary *assetsToPath;

@end
