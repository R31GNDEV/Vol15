/*
Vol15 : Created by Kota
*/

#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>
#include <objc/runtime.h>

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

@property (nonatomic,retain) UIView * fillView;                    //@synthesize materialView=_materialView - In the implementation block
@property (nonatomic,retain) UIView * backgroundView;                              //@synthesize silentModeLabel=_silentModeLabel - In the implementation block
@property (nonatomic,retain) UIView * ringerLabel;                                  //@synthesize ringerLabel=_ringerLabel - In the implementation block
@property (nonatomic,copy,readwrite) UIColor * fillView;
@property (nonatomic,copy,readwrite) UIColor * backgroundView; 

@end

@interface MTMaterialShadowView : UIView
@end

@interface MTMaterialView : UIView
@end

/*
RGB code Created by Snoolie :3, you can find it here: 
*/
UIColor* colorFromHexString(NSString* hexString) {
    NSString *daString = [hexString stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (![daString containsString:@"#"]) {
        daString = [@"#" stringByAppendingString:daString];
    }
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:daString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];

    NSRange range = [hexString rangeOfString:@":" options:NSBackwardsSearch];
    NSString* alphaString;
    if (range.location != NSNotFound) {
        alphaString = [hexString substringFromIndex:(range.location + 1)];
    } else {
        alphaString = @"1.0"; //no opacity specified - just return 1 :/
    }

    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:[alphaString floatValue]];
}

NSUserDefaults *_preferences;
BOOL _enabled;

static bool isNotched()
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        switch ((int)[[UIScreen mainScreen] nativeBounds].size.height)
        {
            case 2436: 
            {
                return YES;
                break;
            }
            case 2688:
            {
                return YES;
                break;
            }
            case 1792:
            {
                return YES;
                break;
            }
            default:
            {
                return NO;
                break;
            }
        }
    }  
    return NO; 
}


%hook SBRingerPillView

// so it looks like for backgroundColor hooking, we wanna hook the SBRingerPillView subviews - but once we get the MTMaterialShadowView, *then* we get the last MTMaterialView subview of *that* subview (it should have a cornerRadius) and then change the backgroundColor
-(NSArray *)subviews {
 id subviews = %orig;
 NSString *colorString = [_preferences objectForKey:@"backgroundColor"];
 if (colorString) {
  for (MTMaterialShadowView * origSubview in subviews) {
   if ([origSubview isMemberOfClass:%c(MTMaterialShadowView)]) {
    NSArray * subviewSubviews = origSubview.subviews;
    //cycle through subviews in the subview
    for (MTMaterialView * thePillBg in subviewSubviews) {
     //the subview we wanna change will have a corner radius of at least 1
     if (thePillBg.layer.cornerRadius >= 1) {
      thePillBg.backgroundColor = colorFromHexString(colorString);
     }
    }
   }
  }
 }
 return subviews;
}

- (id)init 
{
	id x = %orig;
	[self setFrame:(CGRectMake(50, 50,self.frame.size.width,self.frame.size.height))];
	self.alpha = 1;
	self.hidden = NO;
	return x;
}

- (void)didMoveToWindow
{
	self.alpha = 1;
	self.hidden = NO;
	self.onLabel.alpha = 1;
	self.onLabel.hidden = NO;
	self.offLabel.alpha = 1;
	self.offLabel.hidden = NO;
	self.ringerLabel.alpha = 1;
	self.ringerLabel.hidden = NO;
	self.silentModeLabel.alpha = 1;
	self.silentModeLabel.hidden = NO;
	//self.materialView.alpha = 0;
	//self.materialView.hidden = NO;
	self.slider.alpha = 1;
	self.slider.hidden = NO;
	[self setFrame:(CGRectMake(50, 50,self.frame.size.width,self.frame.size.height))];
	%orig;
}

- (void)setFrame:(CGRect)frame
{	
	if (isNotched())
	{
		%orig(CGRectMake(50, 50, frame.size.width, frame.size.height));
	}
	else 
	{
		%orig(CGRectMake(0, -10, frame.size.width, frame.size.height));
	}
	//self.alpha = 1;
	//self.hidden = NO;
}

- (CGRect)frame
{
	CGRect f  = %orig;
	if (isNotched())
	{
		return CGRectMake(50, 50, f.size.width, f.size.height);
	}
	else 
	{
		return CGRectMake(0, -10, f.size.width, f.size.height);
	}
}

- (void)setMaterialView:(UIView *)arg
{
	arg.alpha = 1;
	arg.hidden = NO;
	%orig(arg);
}

-(CALayer *)layer {
  CALayer *origLayer = %orig;
  NSString *glowColorString = [_preferences objectForKey:@"shadowColor"];
  if (glowColorString) {
    origLayer.shadowColor = colorFromHexString(glowColorString).CGColor;
  }
  origLayer.shadowOpacity = 1;
  origLayer.shadowOffset = CGSizeMake(0.0f,4.0f);
  return origLayer;
}

-(void)CGAffineTransform:(UIView *)arg {
   self.materialView.transform = CGAffineTransformMakeRotation(M_PI_2);
   self.slider.transform = CGAffineTransformMakeRotation(M_PI_2);
   %orig(arg);
}

%end

%ctor {
	_preferences = [[NSUserDefaults alloc] initWithSuiteName:@"online.transrights.vol15"];
	[_preferences registerDefaults:@{
		@"enabled" : @YES,
	}];
	_enabled = [_preferences boolForKey:@"enabled"];
	if(_enabled) {
		NSLog(@"[Vol15] Enabled");
		%init();
	} else {
		NSLog(@"[Vol15] Disabled, bye!");
	}
}
