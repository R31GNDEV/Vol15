/*

This is the header file for Vol15 !!!!

*/

#include <UIKit/UIKit.h>

/*

Header(s) *meow*

*/

@class UIView, SBMediaController, SBHUDController, SBRingerHUDViewController, NSString;

@interface SBRingerPillView : UIView
@property(nonatomic, retain) UIView *materialView;
@property(nonatomic, strong, readwrite) UIView *silentModeLabel;
@property(nonatomic, strong, readwrite) UIView *ringerLabel;
@property(nonatomic, strong, readwrite) UIView *onLabel;
@property(nonatomic, strong, readwrite) UIView *offLabel;
@property(nonatomic, strong, readwrite) UIView *slider;
@property(nonatomic, copy, readwrite) UIColor *borderColor;
@property(nonatomic, retain) UIColor *glyphTintColor;
@property(nonatomic, copy, readwrite) UIColor *backgroundColor;
@property(nonatomic, copy) NSArray *glyphTintBackgroundLayers;
@property(nonatomic, copy) NSArray *glyphTintShapeLayers;
@property(assign, nonatomic) unsigned long long state;
@end

@interface SBRingerVolumeSliderView : UIView
@property(nonatomic, copy, readwrite) UIColor *fillView;
@property(nonatomic, copy, readwrite) UIColor *backgroundView;
@end

@interface SBElasticSliderMaterialWrapperView : UIView
@property(nonatomic, assign, readwrite) CGAffineTransform *transform;
@end

@interface MTMaterialView : UIView
@end

@interface MTMaterialShadowView : UIView
{
    MTMaterialView *_materialView;
}
@property(nonatomic, readonly) MTMaterialView *materialView;
@property(nonatomic, assign, readwrite, getter=isOpaque) BOOL opaque;
@end
