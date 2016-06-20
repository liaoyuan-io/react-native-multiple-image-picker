//
//  RCTMultipleImagePicker.m
//  RCTMultipleImagePicker
//
//  Created by ShenTong on 16/6/20.
//
//

#import "RCTMultipleImagePicker.h"

@implementation RCTMultipleImagePicker

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(launchImageGallery:(NSDictionary *)options resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    self.resolve = resolve;
    self.reject = reject;
    NSInteger maxImagesCount = [RCTConvert NSInteger:options[@"maxImagesCount"]];
    
    TZImagePickerController *imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:maxImagesCount delegate:self];
    imagePickerController.allowPickingOriginalPhoto = NO;

    UIViewController *root = [[[[UIApplication sharedApplication] delegate]
                               window] rootViewController];
    [root presentViewController:imagePickerController
                       animated:YES
                     completion:NULL];
}

#pragma mark TZImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    self.reject(@"user_cancelled", @"User has cancelled.", nil);
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePathBase = [[paths objectAtIndex:0] stringByAppendingPathComponent:[[NSProcessInfo processInfo] globallyUniqueString]];
    
    [photos enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger index, BOOL * _Nonnull stop) {
        NSString *path = [filePathBase stringByAppendingPathComponent:[NSString stringWithFormat: @"%d", (int)index]];
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:path atomically:YES];
        [result addObject:path];
    }];
    
    self.resolve(result);
}

@end
