
#import <Cocoa/Cocoa.h>


@interface DateDisplay : NSObject 
{
    IBOutlet NSMenu *appMenu;
//	IBOutlet NSMenuItem *update;
//	IBOutlet NSMenuItem *MMDD;
//	IBOutlet NSMenuItem *DDMM;
	NSStatusItem *menuDateItem;
	NSString *title;
	NSTimer *masterTimer;
	NSString *fmt;
}
//- (IBAction)update:(id)sender;
- (IBAction)setPrefsMMDD:(id)sender;
- (IBAction)setPrefsDDMM:(id)sender;

@end
