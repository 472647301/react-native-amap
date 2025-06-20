package com.amapfoundation

import android.view.View
import com.amap.api.location.AMapLocationClient
import com.amap.api.maps.CameraUpdateFactory
import com.amap.api.maps.MapsInitializer
import com.amap.api.maps.model.CameraPosition
import com.amap.api.maps.model.LatLng
import com.amap.api.maps.model.MarkerOptions
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.ViewGroupManager
import com.facebook.react.uimanager.ViewManagerDelegate
import com.facebook.react.viewmanagers.AmapFoundationViewManagerDelegate
import com.facebook.react.viewmanagers.AmapFoundationViewManagerInterface


@ReactModule(name = AmapFoundationViewManager.NAME)
class AmapFoundationViewManager(context: ReactApplicationContext) : ViewGroupManager<AmapFoundationView>(),
  AmapFoundationViewManagerInterface<AmapFoundationView> {
    private var oldValue: ReadableMap? = null
  private val mDelegate: ViewManagerDelegate<AmapFoundationView> = AmapFoundationViewManagerDelegate(this)

  init {
    MapsInitializer.updatePrivacyAgree(context, true)
    MapsInitializer.updatePrivacyShow(context, true, true)
    AMapLocationClient.updatePrivacyAgree(context, true)
    AMapLocationClient.updatePrivacyShow(context, true, true)
  }

  override fun getDelegate(): ViewManagerDelegate<AmapFoundationView> {
    return mDelegate
  }

  override fun getName(): String {
    return NAME
  }

  override fun createViewInstance(context: ThemedReactContext): AmapFoundationView {
    return AmapFoundationView(context)
  }

  override fun addView(parent: AmapFoundationView, child: View, index: Int) {
    parent.add(child)
    super.addView(parent, child, index)
  }

  override fun removeViewAt(parent: AmapFoundationView, index: Int) {
    parent.remove(parent.getChildAt(index))
    super.removeViewAt(parent, index)
  }

  override fun onDropViewInstance(mapView: AmapFoundationView) {
    super.onDropViewInstance(mapView)
    mapView.onDestroy()
  }

  companion object {
    const val NAME = "AmapFoundationView"
  }

  override fun setAmap(mapView: AmapFoundationView?, value: ReadableMap?) {
    if (value == null) return
    if (oldValue?.getString("apiKey") != value.getString("apiKey")) {
      MapsInitializer.setApiKey(value.getString("apiKey"))
    }
    if (oldValue?.getInt("language") != value.getInt("language")) {
      var lang = "zh_cn";
      if (value.getInt("language") == 1) {
        lang = "en"
      }
      mapView?.map?.setMapLanguage(lang)
    }
    if (oldValue?.getDouble("latitude") != value.getDouble("latitude")) {
      val current = mapView?.map?.cameraPosition
      val zoom = current?.zoom ?: 18.0f
      val tilt = current?.tilt ?: 30.0f
      val bearing = current?.bearing ?: 0.0f
      val latLng = LatLng(value.getDouble("latitude"), value.getDouble("longitude"))
      val cameraUpdate = CameraUpdateFactory.newCameraPosition(
        CameraPosition(latLng, zoom, tilt, bearing)
      )
      mapView?.map?.animateCamera(cameraUpdate)
      val markerOptions = MarkerOptions().position(latLng)
        .title(value.getString("title"))
        .snippet(value.getString("subTitle"))
        .draggable(value.getBoolean("draggable"))
      mapView?.map?.addMarker(markerOptions)?.showInfoWindow()
    }
    oldValue = value
  }
}
