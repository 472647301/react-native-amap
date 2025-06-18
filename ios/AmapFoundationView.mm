#import "AmapFoundationView.h"

#import <react/renderer/components/AmapFoundationViewSpec/ComponentDescriptors.h>
#import <react/renderer/components/AmapFoundationViewSpec/EventEmitters.h>
#import <react/renderer/components/AmapFoundationViewSpec/Props.h>
#import <react/renderer/components/AmapFoundationViewSpec/RCTComponentViewHelpers.h>

#import "RCTFabricComponentsPlugins.h"

using namespace facebook::react;

@interface AmapFoundationView () <RCTAmapFoundationViewViewProtocol, MAMapViewDelegate>

@end

@implementation AmapFoundationView {
    UIView * _view;
    MAMapView * _mapView;
}

+ (ComponentDescriptorProvider)componentDescriptorProvider
{
    return concreteComponentDescriptorProvider<AmapFoundationViewComponentDescriptor>();
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        static const auto defaultProps = std::make_shared<const AmapFoundationViewProps>();
        _props = defaultProps;
        
        _view = [[UIView alloc] init];
       
        self.contentView = _view;
    }
    return self;
}

- (void)updateProps:(Props::Shared const &)props oldProps:(Props::Shared const &)oldProps
{
    const auto &oldViewProps = *std::static_pointer_cast<AmapFoundationViewProps const>(_props);
    const auto &newViewProps = *std::static_pointer_cast<AmapFoundationViewProps const>(props);
  
    if (oldViewProps.amap.apiKey != newViewProps.amap.apiKey) {
      [[AMapServices sharedServices] setEnableHTTPS:YES];
      [AMapServices sharedServices].apiKey = [[NSString alloc] initWithUTF8String: newViewProps.amap.apiKey.c_str()];
    }
    if (_mapView == nil) {
        [MAMapView updatePrivacyShow:AMapPrivacyShowStatusDidShow privacyInfo:AMapPrivacyInfoStatusDidContain];
        [MAMapView updatePrivacyAgree:AMapPrivacyAgreeStatusDidAgree];
        _mapView = [[MAMapView alloc] initWithFrame:_view.bounds];
        _mapView.delegate = self;
        [_view addSubview:_mapView];
    }
    if (_mapView != nil && oldViewProps.amap.language != newViewProps.amap.language) {
        _mapView.mapLanguage = @(newViewProps.amap.language);
    }
    if (_mapView != nil && oldViewProps.amap.latitude != newViewProps.amap.latitude) {
        [_mapView setCenterCoordinate:CLLocationCoordinate2D(newViewProps.amap.latitude, newViewProps.amap.longitude) animated:YES];
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(newViewProps.amap.latitude, newViewProps.amap.longitude);
        pointAnnotation.title = [[NSString alloc] initWithUTF8String: newViewProps.amap.title.c_str()];
        pointAnnotation.subtitle = [[NSString alloc] initWithUTF8String: newViewProps.amap.subTitle.c_str()];
        [_mapView addAnnotation:pointAnnotation];
    }
    [super updateProps:props oldProps:oldProps];
}

Class<RCTComponentViewProtocol> AmapFoundationViewCls(void)
{
    return AmapFoundationView.class;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        const auto &viewProps = *std::static_pointer_cast<AmapFoundationViewProps const>(_props);
        annotationView.canShowCallout= viewProps.amap.canShowCallout;
        annotationView.animatesDrop = viewProps.amap.animatesDrop;
        annotationView.draggable = viewProps.amap.draggable;
        switch (viewProps.amap.pinColor) {
          case 0:
            annotationView.pinColor = MAPinAnnotationColorRed;
            break;
          case 1:
            annotationView.pinColor = MAPinAnnotationColorGreen;
            break;
          case 2:
            annotationView.pinColor = MAPinAnnotationColorPurple;
            break;
          default:
            annotationView.pinColor = MAPinAnnotationColorRed;
            break;
        }
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    [mapView selectAnnotation:[[mapView annotations] lastObject] animated:YES];
}

@end
