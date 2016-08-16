# react-native-multiple-image-picker
React Native Multiple Image Picker is a React Native native module wrapping [TZImagePickerController](https://github.com/banchichen/TZImagePickerController) for iOS and [RxGalleryFinal](https://github.com/FinalTeam/RxGalleryFinal) for Android.

## Known Issues

Currently, [RxGalleryFinal](https://github.com/FinalTeam/RxGalleryFinal) is still in a pre-release stage and is NOT READY for production yet. Image previews are not presented in correct aspect ratios.

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
    maxImagesCount: 9,      // Max number of images user can select
    selectedPaths: [
        '/Users/tshen/Library/Developer/CoreSimulator/Devices/8C416B45-F555-4A63-A1B0-09E61109F0A0/data/Containers/Data/Application/A1790255-CDE8-486C-A6BA-1693BA2AA87B/Documents/BB6ADD56-09E7-402C-BF0E-AD79400D3889-7539-000007B93A6B5733/0.jpg',
        '/Users/tshen/Library/Developer/CoreSimulator/Devices/8C416B45-F555-4A63-A1B0-09E61109F0A0/data/Containers/Data/Application/A1790255-CDE8-486C-A6BA-1693BA2AA87B/Documents/BB6ADD56-09E7-402C-BF0E-AD79400D3889-7539-000007B93A6B5733/1.jpg',
        '/Users/tshen/Library/Developer/CoreSimulator/Devices/8C416B45-F555-4A63-A1B0-09E61109F0A0/data/Containers/Data/Application/A1790255-CDE8-486C-A6BA-1693BA2AA87B/Documents/BB6ADD56-09E7-402C-BF0E-AD79400D3889-7539-000007B93A6B5733/2.jpg',
        '/Users/tshen/Library/Developer/CoreSimulator/Devices/8C416B45-F555-4A63-A1B0-09E61109F0A0/data/Containers/Data/Application/A1790255-CDE8-486C-A6BA-1693BA2AA87B/Documents/BB6ADD56-09E7-402C-BF0E-AD79400D3889-7539-000007B93A6B5733/3.jpg'
    ]                       // Currently selected paths, must be from result of previous calls
};
MultipleImagePicker.launchImageGallery(options).then((newSelectedPaths) => {
    // newSelectedPaths will be an Array of String, like [ '/path/1', '/path/2' ], and may be used for `selectedPaths` on the next invocation
});

// single mode - Android only
const singleOptions = {
    single: true
};
MultipleImagePicker.launchImageGallery(singleOptions).then((path) => {
    // path will be a String, like 'file:///storage/sdcard/Download/IMG_0617.JPG'
});

```