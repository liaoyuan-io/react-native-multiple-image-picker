# react-native-multiple-image-picker
React Native Multiple Image Picker is a React Native native module wrapping [TZImagePickerController](https://github.com/banchichen/TZImagePickerController) for iOS (iOS 8+ for using PhotoKit) and [RxGalleryFinal](https://github.com/FinalTeam/RxGalleryFinal) for Android (Android 4.1+). This module allows you to pick multiple images for further processing.

React Native Multiple Image Picker 多图片选择器 是一个 React Native 原生模块，封装了 [TZImagePickerController](https://github.com/banchichen/TZImagePickerController)（用于 iOS 8+，因为使用了 PhotoKit）和 [RxGalleryFinal](https://github.com/FinalTeam/RxGalleryFinal)（用于 Android 4.1+，尚处于**试验阶段**）。使用这个模块你可以一次选择多张图片，以供进一步处理。

## Known Issues

- Currently, [RxGalleryFinal](https://github.com/FinalTeam/RxGalleryFinal) is still in a **pre-release** stage and is **NOT READY for production** yet. Image previews are not presented in correct aspect ratios.
- The `master` branch is still using the old React Native import path. If you has upgrade to React Native 0.40+ , please use `rn40` branch instead. 

## Install

### iOS

1. Run `npm install --save liaoyuan-io/react-native-multiple-image-picker` .
2. Add `RCTMultipleImagePicker` to your iOS project.
3. Add `libRCTMultipleImagePicker.a` to your `Link Binary with Libraries` section in `Build Phases` .
4. Add `TZImagePickerController.bundle` to your `Resources` group and `Copy Bundle Resources` section in `Build Phases` .

### Android

1. Run `npm install --save liaoyuan-io/react-native-multiple-image-picker` .
2. Add `new MultipleImagePickerPackage()` to your `getPackages` return in `android/app/src/main/java/com/your/path/MainApplication.java`.
3. Add following to your `android/app/src/main/AndroidManifest.xml`:
    ```
    // permission declaration
    <uses-feature android:name="android.hardware.camera" android:required="true"/>
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    
    // in application
        <activity
                android:name="cn.finalteam.rxgalleryfinal.ui.activity.MediaActivity"
                android:exported="true"
                android:screenOrientation="portrait"/>
    ```
4. Add `compile project(':react-native-multiple-image-picker')` to `dependencies` section in `android/app/build.gradle` .
5. Add following to your `android/settings.gradle`:

    ```
    include ':react-native-multiple-image-picker'
    project(':react-native-multiple-image-picker').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-multiple-image-picker/android')
    ```
    
## Usage

```javascript
import MultipleImagePicker from 'react-native-multiple-image-picker';

const options = {
    maxImagesCount: 9,      // Max number of images user can select; if maxImagesCount == 1, Single mode (i.e. Tap to Select & Finish) will be activated.
    selectedPaths: [
        '/Users/tshen/Library/Developer/CoreSimulator/Devices/8C416B45-F555-4A63-A1B0-09E61109F0A0/data/Containers/Data/Application/A1790255-CDE8-486C-A6BA-1693BA2AA87B/Documents/BB6ADD56-09E7-402C-BF0E-AD79400D3889-7539-000007B93A6B5733/0.jpg',
        '/Users/tshen/Library/Developer/CoreSimulator/Devices/8C416B45-F555-4A63-A1B0-09E61109F0A0/data/Containers/Data/Application/A1790255-CDE8-486C-A6BA-1693BA2AA87B/Documents/BB6ADD56-09E7-402C-BF0E-AD79400D3889-7539-000007B93A6B5733/1.jpg',
        '/Users/tshen/Library/Developer/CoreSimulator/Devices/8C416B45-F555-4A63-A1B0-09E61109F0A0/data/Containers/Data/Application/A1790255-CDE8-486C-A6BA-1693BA2AA87B/Documents/BB6ADD56-09E7-402C-BF0E-AD79400D3889-7539-000007B93A6B5733/2.jpg',
        '/Users/tshen/Library/Developer/CoreSimulator/Devices/8C416B45-F555-4A63-A1B0-09E61109F0A0/data/Containers/Data/Application/A1790255-CDE8-486C-A6BA-1693BA2AA87B/Documents/BB6ADD56-09E7-402C-BF0E-AD79400D3889-7539-000007B93A6B5733/3.jpg'
    ]                       // Currently selected paths, must be from result of previous calls. Empty array allowed.
};
MultipleImagePicker.launchImageGallery(options).then((newSelectedPaths) => {
    // newSelectedPaths will be an Array of String, like [ '/path/1', '/path/2' ], and may be used for `selectedPaths` on the next invocation
});
```

## Error Codes

| Code                          | Platform         | Description                                                                                                            |
| ----------------------------- | ---------------- | ---------------------------------------------------------------------------------------------------------------------- |
| camera_permission_not_granted | iOS              | User has not granted CAMERA permission to your app. Should guide user to Settings > Privacy > Camera .                 |
| create_directory_failed       | iOS              | The app has failed to create the temp folder for photo processing due to insufficient storage or other system errors.  |
| user_cancelled                | iOS              | User has cancelled the image picker.                                                                                   |
