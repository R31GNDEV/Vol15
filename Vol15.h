/*

This is the header file for Vol15 !!!!

*/

#include <UIKit/UIKit.h>

/*

Header(s) *meow*

*/

@class UIView, SBMediaController, SBHUDController, SBRingerHUDViewController, NSString;

@interface SBRingerPillView : UIView

@property (nonatomic,retain) UIView * materialView;                    //@synthesize materialView=_materialView - In the implementation block
@property (nonatomic,retain) UIView * silentModeLabel;                              //@synthesize silentModeLabel=_silentModeLabel - In the implementation block
@property (nonatomic,retain) UIView * ringerLabel;                                  //@synthesize ringerLabel=_ringerLabel - In the implementation block
@property (nonatomic,retain) UIView * onLabel;                                      //@synthesize onLabel=_onLabel - In the implementation block
@property (nonatomic,retain) UIView * offLabel;                                     //@synthesize offLabel=_offLabel - In the implementation block
@property (nonatomic,retain) UIView * slider;                      //@synthesize slider=_slider - In the implementation block
@property (nonatomic,copy,readwrite) UIColor * borderColor;
@property (nonatomic,retain) UIColor * glyphTintColor;                               //@synthesize glyphTintColor=_glyphTintColor - In the implementation block
@property (nonatomic,copy,readwrite) UIColor * backgroundColor; 
@property (nonatomic,copy) NSArray * glyphTintBackgroundLayers;                      //@synthesize glyphTintBackgroundLayers=_glyphTintBackgroundLayers - In the implementation block
@property (nonatomic,copy) NSArray * glyphTintShapeLayers;                           //@synthesize glyphTintShapeLayers=_glyphTintShapeLayers - In the implementation block
@property (assign,nonatomic) unsigned long long state;  

@end

@interface SBRingerVolumeSliderView : UIView
@end

@interface MTMaterialShadowView : UIView {
 MTMaterialView* _materialView;
}
@property (nonatomic,readonly) MTMaterialView * materialView;  
@end

@interface MTMaterialView : UIView
@end
