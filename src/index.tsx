import AMapFoundationView from './AmapFoundationViewNativeComponent';
import type { AmapFoundationViewProps } from './AmapFoundationViewNativeComponent';
import type { AMapProps } from './AmapFoundationViewNativeComponent';

export interface AMapViewProps extends Omit<AmapFoundationViewProps, 'amap'> {
  amap: Partial<AMapProps>;
}

export type { AMapProps };

export const AMapView = (props: AMapViewProps) => {
  const amap: AMapProps = {
    title: '',
    subTitle: '',
    latitude: 0,
    longitude: 0,
    canShowCallout: true,
    animatesDrop: true,
    draggable: true,
    pinColor: 0,
    language: 0,
    apiKey: '',
    ...props.amap,
  };
  return <AMapFoundationView {...props} amap={amap} />;
};
