#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>

@interface VOLRootListController : PSListController

@end

@interface NSTask : NSObject
@property (copy) NSArray *arguments;
@property (copy) NSString *launchPath;
- (id)init;
- (void)waitUntilExit;
- (void)launch;
@end

@class NSString;

@interface PSTextFieldSpecifier : PSSpecifier {

	SEL bestGuess;
	NSString* _placeholder;
}
+(id)specifierWithSpecifier:(id)arg1 ;
+(id)preferenceSpecifierNamed:(id)arg1 target:(id)arg2 set:(SEL)arg3 get:(SEL)arg4 detail:(Class)arg5 cell:(long long)arg6 edit:(Class)arg7 ;
-(BOOL)isEqualToSpecifier:(id)arg1 ;
-(void)setPlaceholder:(id)arg1 ;
-(id)placeholder;
@end