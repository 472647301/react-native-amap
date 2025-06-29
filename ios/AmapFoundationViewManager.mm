#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>
#import "RCTBridge.h"

@interface AmapFoundationViewManager : RCTViewManager
@end

@implementation AmapFoundationViewManager

RCT_EXPORT_MODULE(AmapFoundationView)

- (UIView *)view
{
  return [[UIView alloc] init];
}

RCT_EXPORT_VIEW_PROPERTY(color, NSString)

@end
