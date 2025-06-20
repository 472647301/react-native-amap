import codegenNativeComponent from 'react-native/Libraries/Utilities/codegenNativeComponent';
import type { ViewProps } from 'react-native';
import type { Double, Int32 } from 'react-native/Libraries/Types/CodegenTypes';

export interface AMapProps {
  title: string;
  subTitle: string;
  latitude: Double;
  longitude: Double;
  /** 设置气泡可以弹出，默认为 true */
  canShowCallout: boolean;
  /** 设置标注动画显示，默认为 true */
  animatesDrop: boolean;
  /** 设置标注可以拖动，默认为 true */
  draggable: boolean;
  /** 0代表中文，1代表英文 */
  language: Int32;
  /** 0=红色大头针, 1=绿色大头针, 2=紫色大头针 */
  pinColor: Int32;
  apiKey: string;
}

export interface AmapFoundationViewProps extends ViewProps {
  amap: AMapProps;
}

export default codegenNativeComponent<AmapFoundationViewProps>(
  'AmapFoundationView'
);
