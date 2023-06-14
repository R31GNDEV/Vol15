/*
Vol15 : Created by Kota & Snoolie
*/

//since in the header we already have the needed #include's
//we don't need to add more
#include "Vol15.h"

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

/*
Get if a Device is notched or not for frame positioning.
*/

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

/*
Modify UI Labels
*/

__attribute__((always_inline)) static void modifyLabel(UILabel *daLabel) {
    NSString *textSex = [_preferences objectForKey:@"textSexKey"];
    if (textSex) {
        daLabel.textColor = colorFromHexString(textSex);
    }
    NSString *textSexShadow = [_preferences objectForKey:@"textSexShadowKey"];
    if (textSexShadow) {
        daLabel.layer.shadowColor = colorFromHexString(textSexShadow).CGColor;
    }
 daLabel.layer.shadowOpacity = 1.0;
 daLabel.layer.shadowOffset = CGSizeMake(0,0);
}


/*
Hook 1
*/

%hook SBRingerVolumeSliderView

-(NSArray *)subviews {
  NSArray *subviews = %orig;
  UIView *backgroundView = subviews[0];
  if (backgroundView) {
   NSString *sliderBackgroundView = [_preferences objectForKey:@"sliderBg"];
   if (sliderBackgroundView) {
    backgroundView.backgroundColor = colorFromHexString(sliderBackgroundView);
   }
  }
   NSArray *backgroundViewSubviews = %orig;
   if (backgroundViewSubviews) {
    UIView *fillView = backgroundViewSubviews[0];
    if (fillView) {
     NSString *sliderFillView = [_preferences objectForKey:@"sliderActive"];
     if (sliderFillView) {
      fillView.backgroundColor = colorFromHexString(sliderFillView);
     }
    }
   }
 return subviews;
}

%end

/*
Hook 2
*/

%hook SBElasticSliderMaterialWrapperView
/* test this
-(CGAffineTransform)transform {
    self.transform = CGAffineTransformMakeRotation(M_PI/2.0);
}
*/
-(NSArray *)subviews {
 NSArray *subviews = %orig;
 if (subviews) {
   NSString *volColor = [_preferences objectForKey:@"backgroundVolColor"];
   if (volColor) {
    self.backgroundColor = colorFromHexString(volColor);
   }
 }
 return subviews;
}

-(CALayer *)layer {
  CALayer *origLayer = %orig;
  NSString *volShadowColorString = [_preferences objectForKey:@"volShadowColor"];
  if (volShadowColorString) {
    origLayer.shadowColor = colorFromHexString(volShadowColorString).CGColor;
  }
  origLayer.shadowOpacity = 1;
  origLayer.shadowOffset = CGSizeMake(3.0f,3.0f);
  return origLayer;
}

%end

/*
Hook 3
*/

%hook SBRingerPillView

-(MTMaterialShadowView *)materialView {
 //get the original material shadow view
 MTMaterialShadowView *materialShadowView = %orig;
 //MTMaterialShadowView will store the MTMaterialView property on it 
 MTMaterialView* materialView = materialShadowView.materialView;
 //safety check, make sure materialView is not NULL :P
 if (materialView) {
  NSString *colorString = [_preferences objectForKey:@"backgroundColor"];
  if (colorString) {
   materialView.layer.backgroundColor = colorFromHexString(colorString).CGColor;
  }
  CGFloat setCornerRadius = [_preferences floatForKey:@"cornerRadius"];
  if (!(setCornerRadius >= 0)){
    setCornerRadius = 1;
  }
  materialView.layer.cornerRadius = setCornerRadius;
 }
 return materialShadowView;
}

-(UILabel *)ringerLabel {
 //the header of the ringer slider when it says "Ringer"
 UILabel *ringerLabel = %orig;
 //make changes to the ringerLabel
 modifyLabel(ringerLabel);
 return ringerLabel;
}

-(UILabel *)silentModeLabel {
 //the header of the ringer slider when it says "Silent Mode"
 UILabel *silentModeLabel = %orig;
 //make changes to the silentModeLabel
 modifyLabel(silentModeLabel);
 return silentModeLabel;
}

-(UILabel *)onLabel {
 //the header of the ringer slider when it says "On"
 UILabel *onLabel = %orig;
 //make changes to the onLabel
 modifyLabel(onLabel);
 return onLabel;
}

-(UILabel *)offLabel {
 //the header of the ringer slider when it says "Off"
 UILabel *offLabel = %orig;
 //make changes to the offLabel
 modifyLabel(offLabel);
 return offLabel;
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
	self.materialView.alpha = 0.5;
	//self.materialView.hidden = YES;
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
/* Still testing (Vertical Ringer)
*/
%end

/*
Init prefs
*/

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