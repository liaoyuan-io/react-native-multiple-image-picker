# react-native-multiple-image-picker
React Native Multiple Image Picker is a React Native native module (currently iOS only) wrapping [TZImagePickerController](https://github.com/banchichen/TZImagePickerController).

## Install

1. Run `npm install --save liaoyuan-io/react-native-multiple-image-picker` .

2. Add `RCTMultipleImagePicker` to your iOS project.

3. Add `libRCTMultipleImagePicker.a` to your `Link Binary with Libraries` section in `Build Phases` .

4. Add `TZImagePickerController.bundle` to your `Resources` group and `Copy Bundle Resources` section in `Build Phases` .

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
MultipleImagePicker.launchImageGallery(options);
```