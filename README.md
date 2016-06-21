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
    maxImagesCount: 9       // Max number of images user can select
};
MultipleImagePicker.launchImageGallery(options);
```