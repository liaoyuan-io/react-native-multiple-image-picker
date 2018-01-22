package io.liaoyuan.reactnative.multipleimagepicker;

import android.util.Log;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableArray;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.finalteam.rxgalleryfinal.RxGalleryFinal;
import cn.finalteam.rxgalleryfinal.imageloader.ImageLoaderType;
import cn.finalteam.rxgalleryfinal.rxbus.RxBusResultDisposable;
import cn.finalteam.rxgalleryfinal.rxbus.event.ImageMultipleResultEvent;
import cn.finalteam.rxgalleryfinal.rxbus.event.ImageRadioResultEvent;
import cn.finalteam.rxgalleryfinal.bean.MediaBean;

/**
 * Created by tshen on 16/8/10.
 */
public class MultipleImagePicker extends ReactContextBaseJavaModule {

    private Map<String, MediaBean> assetsFromPath = new HashMap<String, MediaBean>();

    public MultipleImagePicker(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "MultipleImagePicker";
    }

    private List<MediaBean> getMediaBeanListFromPathList(ReadableArray selectedPaths) {
        List<MediaBean> result = new ArrayList<MediaBean>();
        for (int i = 0; i < selectedPaths.size(); i++) {
            String currentPath = selectedPaths.getString(i);
            if (currentPath != null && this.assetsFromPath.containsKey(currentPath)) {
                MediaBean bean = this.assetsFromPath.get(currentPath);
                if (bean != null) {
                    result.add(bean);
                }
            }
        }
        return result;
    }

    @ReactMethod
    public void launchImageGallery(ReadableMap options, final Promise promise) {
        boolean single;
        int maxImagesCount;

        single = options.hasKey("maxImagesCount") && options.getInt("maxImagesCount") == 1;

        if (options.hasKey("maxImagesCount")) {
            maxImagesCount = options.getInt("maxImagesCount");
        } else {
            maxImagesCount = 9;
        }

        RxGalleryFinal rxGalleryFinal = RxGalleryFinal.with(getCurrentActivity()).image();

        if (single) {
            rxGalleryFinal.radio().imageLoader(ImageLoaderType.PICASSO).subscribe(new RxBusResultDisposable<ImageRadioResultEvent>() {
                @Override
                protected void onEvent(ImageRadioResultEvent imageRadioResultEvent) throws Exception {
                    WritableArray paths = Arguments.createArray();
                    paths.pushString("file://" + imageRadioResultEvent.getResult().getOriginalPath());
                    promise.resolve(paths);
                }
            }).openGallery();
        } else {
            if (options.hasKey("selectedPaths")) {
                ReadableArray selectedPaths = options.getArray("selectedPaths");
                if (selectedPaths != null) {
                    rxGalleryFinal.selected(this.getMediaBeanListFromPathList(selectedPaths));
                }
            }
            rxGalleryFinal.multiple().maxSize(maxImagesCount).imageLoader(ImageLoaderType.PICASSO).subscribe(new RxBusResultDisposable<ImageMultipleResultEvent>() {
                @Override
                protected void onEvent(ImageMultipleResultEvent imageMultipleResultEvent) throws Exception {
                    List<MediaBean> list = imageMultipleResultEvent.getResult();
                    WritableArray paths = Arguments.createArray();
                    for (MediaBean bean : list) {
                        String path = "file://" + bean.getOriginalPath();
                        paths.pushString(path);
                        MultipleImagePicker.this.assetsFromPath.put(path, bean);
                    }
                    promise.resolve(paths);
                }
            }).openGallery();
        }
    }
}
