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
@property(nonatomic, retain) UIView *silentModeLabel;
@property(nonatomic, retain) UIView *ringerLabel;
@property(nonatomic, retain) UIView *onLabel;
@property(nonatomic, retain) UIView *offLabel;
@property(nonatomic, retain) UIView *slider;
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
@end

@interface MTMaterialView : UIView
@end

@interface MTMaterialShadowView : UIView
{
    MTMaterialView *_materialView;
}
@property(nonatomic, readonly) MTMaterialView *materialView;
@end
