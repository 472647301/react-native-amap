import AMapFoundationView from './AmapFoundationViewNativeComponent';
import type { AmapFoundationViewProps } from './AmapFoundationViewNativeComponent';
import type { AMapProps } from './AmapFoundationViewNativeComponent';
import { PinColor } from './AmapFoundationViewNativeComponent';

export interface AMapViewProps extends Omit<AmapFoundationViewProps, 'amap'> {
  amap: Partial<AMapProps>;
}

export { PinColor };
export type { AMapProps };

export const AMapView = (props: AMapViewProps) => {
  const amap = {
    title: '',
    subTitle: '',
    latitude: 0,
    longitude: 0,
    canShowCallout: true,
    animatesDrop: true,
    draggable: true,
    pinColor: PinColor.PinColorRed,
    language: 0,
    apiKey: '',
    ...props.amap,
  };
  return <AMapFoundationView {...props} amap={amap} />;
};
