package cn.finalteam.rxgalleryfinal.rxbus;

import cn.finalteam.rxgalleryfinal.rxbus.event.BaseResultEvent;
import cn.finalteam.rxgalleryfinal.rxbus.event.ImageMultipleResultEvent;

/**
 * Desction:
 * Author:pengjianbo
 * Date:16/8/1 下午11:11
 */
public abstract class RxBusResultSubscriber<T extends BaseResultEvent> extends RxBusSubscriber<T>  {
}
