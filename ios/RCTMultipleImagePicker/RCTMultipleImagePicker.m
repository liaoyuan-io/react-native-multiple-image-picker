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

-(id)init {
    self = [super init];
    if(self) {
        self.assets = [[NSMutableDictionary alloc] init];
    }
    return self;
}

RCT_EXPORT_METHOD(launchImageGallery:(NSDictionary *)options resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    self.resolve = resolve;
    self.reject = reject;
    NSInteger maxImagesCount = [RCTConvert NSInteger:options[@"maxImagesCount"]];
    NSArray *selectedPaths = [RCTConvert NSArray:options[@"selectedPaths"]];
    NSMutableArray *selectedAssets = [[NSMutableArray alloc] init];
    [selectedPaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *path = [RCTConvert NSString:obj];
        [selectedAssets addObject:[self.assets objectForKey:path]];
    }];
    
    TZImagePickerController *imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:maxImagesCount delegate:self];
    imagePickerController.allowPickingOriginalPhoto = NO;
    imagePickerController.selectedAssets = selectedAssets;

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

    NSError * error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:filePathBase
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    if (error != nil) {
        NSLog(@"error creating directory: %@", error);
        self.reject(@"create_directory_failed", @"Fail to create directory.", error);
    }
    
    [photos enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger index, BOOL * _Nonnull stop) {
        NSString *path = [filePathBase stringByAppendingPathComponent:[NSString stringWithFormat: @"%d.jpg", (int)index]];
        [UIImageJPEGRepresentation(image, 1.0) writeToFile:path atomically:YES];
        [result addObject:path];
        [self.assets setObject:[assets objectAtIndex:index] forKey:path];
    }];
    
    self.resolve(result);
}

@end
