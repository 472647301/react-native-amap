package com.amapfoundation

import com.amap.api.maps.AMap

interface Overlay {
  fun add(map: AMap)
  fun remove()
}