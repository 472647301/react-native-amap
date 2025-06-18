package com.amapfoundation

import android.graphics.Color
import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.uimanager.SimpleViewManager
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.ViewManagerDelegate
import com.facebook.react.uimanager.annotations.ReactProp
import com.facebook.react.viewmanagers.AmapFoundationViewManagerInterface
import com.facebook.react.viewmanagers.AmapFoundationViewManagerDelegate

@ReactModule(name = AmapFoundationViewManager.NAME)
class AmapFoundationViewManager : SimpleViewManager<AmapFoundationView>(),
  AmapFoundationViewManagerInterface<AmapFoundationView> {
  private val mDelegate: ViewManagerDelegate<AmapFoundationView>

  init {
    mDelegate = AmapFoundationViewManagerDelegate(this)
  }

  override fun getDelegate(): ViewManagerDelegate<AmapFoundationView>? {
    return mDelegate
  }

  override fun getName(): String {
    return NAME
  }

  public override fun createViewInstance(context: ThemedReactContext): AmapFoundationView {
    return AmapFoundationView(context)
  }

  @ReactProp(name = "color")
  override fun setColor(view: AmapFoundationView?, color: String?) {
    view?.setBackgroundColor(Color.parseColor(color))
  }

  companion object {
    const val NAME = "AmapFoundationView"
  }
}
