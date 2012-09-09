
#import "DateDisplay.h"


@implementation DateDisplay
- (id) init // required: init
{
	self = [super init];	
	return self;
}
// Remove the dock, app menu, and option-tab with <key>LSUIElement</key>
- (void) activateMenu // initialize the status app
{
	NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
	menuDateItem = [statusBar statusItemWithLength: NSVariableStatusItemLength];
	[menuDateItem retain];
		
	// Set the initial title for the menu.
	[menuDateItem setTitle: @"00/00"];
	[menuDateItem setHighlightMode: YES];
	[menuDateItem setMenu: appMenu];
	
	[statusBar removeStatusItem: menuDateItem]; 	// Now we remove it and re-add it on the right
	[statusBar _insertStatusItem: menuDateItem withPriority:INT_MAX-1]; // secret stuff
}

- (void) update // change the text on the app
{
	// Get datefmt string
	CFStringRef DateFmtKey = CFSTR("DateFmt");
	CFStringRef DateFmt;
	DateFmt = (CFStringRef)CFPreferencesCopyAppValue(DateFmtKey,  kCFPreferencesCurrentApplication);
	if (DateFmt) {
		fmt = (NSString*) DateFmt;
		CFRelease(DateFmtKey);
	} else {
		[self setPrefsMMDD: (id)1];
		DateFmt = (CFStringRef)CFPreferencesCopyAppValue(DateFmtKey,  kCFPreferencesCurrentApplication);
		fmt = (NSString*) DateFmt;
		CFRelease(DateFmtKey);
	}

	title = [ [NSDate date]descriptionWithCalendarFormat: fmt timeZone:nil \
		locale:[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] ];
	[menuDateItem setTitle: title];
}

-(void) awakeFromNib // required: caled after the nib is loaded
{
	[self activateMenu];
	masterTimer = [[NSTimer scheduledTimerWithTimeInterval:
           10                                // a 10s time interval
           target:self                       // Target is this object
           selector:@selector(update)       // What function are we calling
           userInfo:nil repeats:YES]         // No userinfo / repeat infinitely
           retain];
}

-(IBAction) setPrefsMMDD:(id)sender
{
	CFStringRef DateFmtKey = CFSTR("DateFmt");
	CFStringRef DateFmt = CFSTR("%m/%d");
	CFPreferencesSetAppValue(DateFmtKey, DateFmt, kCFPreferencesCurrentApplication);
	CFPreferencesAppSynchronize(kCFPreferencesCurrentApplication);
	[self update];
}

-(IBAction) setPrefsDDMM:(id)sender
{
	CFStringRef DateFmtKey = CFSTR("DateFmt");
	CFStringRef DateFmt = CFSTR("%d/%m");
	CFPreferencesSetAppValue(DateFmtKey, DateFmt, kCFPreferencesCurrentApplication);
	CFPreferencesAppSynchronize(kCFPreferencesCurrentApplication);
	[self update];
}

- (void) dealloc // on quit
{
	[super dealloc];
}

@end
