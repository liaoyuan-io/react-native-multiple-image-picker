//
//  RCTMultipleImagePicker.h
//  RCTMultipleImagePicker
//
//  Created by ShenTong on 16/6/20.
//
//

#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"
#import "RCTConvert.h"
#import "RCTLog.h"
#import <TZImagePickerController/TZImagePickerController.h>


@interface RCTMultipleImagePicker : NSObject <RCTBridgeModule, TZImagePickerControllerDelegate>

@property (nonatomic, strong) RCTPromiseResolveBlock resolve;
@property (nonatomic, strong) RCTPromiseRejectBlock reject;

@end
