#import <Preferences/PSListController.h>

@interface VOLRootListController : PSListController

@end

@interface NSTask : NSObject
@property (copy) NSArray *arguments;
@property (copy) NSString *launchPath;
- (id)init;
- (void)waitUntilExit;
- (void)launch;
@end