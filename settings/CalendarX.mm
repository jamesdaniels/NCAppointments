#import <Preferences/Preferences.h>

@interface CalendarXListController: PSListController {
}
@end

@implementation CalendarXListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"CalendarX" target:self] retain];
	}
	return _specifiers;
}
@end

// vim:ft=objc
