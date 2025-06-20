package com.amapfoundation

import android.annotation.SuppressLint
import android.view.View
import com.amap.api.maps.TextureMapView
import com.facebook.react.uimanager.ThemedReactContext

@SuppressLint("ViewConstructor")
class AmapFoundationView(context: ThemedReactContext) : TextureMapView(context) {

  init {
    super.onCreate(null)
  }

  fun add(child: View) {
    if (child is Overlay) {
      child.add(map)
    }
  }

  fun remove(child: View) {
    if (child is Overlay) {
      child.remove()
    }
  }
}
