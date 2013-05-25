#import "CalendarXAppController-Protocol.h"
#import "EventKit/EventKit.h"

static NSBundle *_CalendarXAppBundle = nil;

@interface CalendarXController: NSObject <CalendarXAppController> {
	UIView *_view;
}
@property (nonatomic, retain) UIView *view;
@end

@implementation CalendarXController
@synthesize view = _view;

+ (void)initialize {
	_CalendarXAppBundle = [[NSBundle bundleForClass:[self class]] retain];
}

- (id)init {
	if((self = [super init]) != nil) {
		
	} return self;
}

- (void)dealloc {
	[_view release];
	[super dealloc];
}

- (void)loadFullView {
  _view = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, {316.f, 315.f}}];
}

- (void)viewDidAppear {

  [_view release];
  
  _view = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, {316.f, 315.f}}];

  EKEventStore *store = [[EKEventStore alloc] init];

  NSCalendar *calendar = [NSCalendar currentCalendar];

  // Create the end date components
  NSDateComponents *oneYearFromNowComponents = [[NSDateComponents alloc] init];
  oneYearFromNowComponents.day = 14;
  NSDate *oneYearFromNow = [calendar dateByAddingComponents:oneYearFromNowComponents
                                                     toDate:[NSDate date]
                                                    options:0];
   
  // Create the predicate from the event store's instance method
  NSPredicate *predicate = [store predicateForEventsWithStartDate:[NSDate date]
                                                          endDate:oneYearFromNow
                                                        calendars:nil];
   
  // Fetch all events that match the predicate
  NSArray *events = [store eventsMatchingPredicate:predicate];
  

  NSEnumerator *e = [events objectEnumerator];
  id object;
  int offset = 10;
  int left = 5;
  int width = 316 - 20;
  int height = 750;

  NSString *lastDate = @"";
  NSString *lastFingerprint = @"";
  NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
  [dateFormatter setDateFormat:@" E d"];

  NSDateFormatter* timeFormatter = [[[NSDateFormatter alloc] init] autorelease];
  [timeFormatter setDateFormat:@"h:mma"];

  while ((object = [e nextObject])) {
    // do something with object
    if (offset >= height) {

      break;

    } else {

      if ([object isAllDay] || [object status] == EKEventStatusCanceled) {

      } else {

        NSString *newDate = [dateFormatter stringFromDate:[object startDate]];
        
        NSString* start = [timeFormatter stringFromDate:[object startDate]];
        NSString* end = [timeFormatter stringFromDate:[object endDate]];

        NSString *location = nil;
        NSString *newFingerprint = @"";

        if (location) {
          newFingerprint = [NSString stringWithFormat:@"%@\n%@\n%@-%@\n%@", newDate, [object title], start, end, location];
        } else {
          newFingerprint = [NSString stringWithFormat:@"%@\n%@\n%@-%@", newDate, [object title], start, end];
        }

        if ([newFingerprint isEqualToString:lastFingerprint]) {

        } else {

          if ([newDate isEqualToString:lastDate]) {

            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(left - 5, offset, width + 10, 1)];
            lineView.alpha = 0.3;
            lineView.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:lineView];
            [lineView release];

            offset += 1;
            offset += 8;


          } else {
            
            UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(left - 5, offset, width + 10, 20)];
            dateLabel.alpha = 0.3;
            dateLabel.text = newDate;

            [dateLabel setTextColor:[UIColor blackColor]];
            [dateLabel setBackgroundColor:[UIColor whiteColor]];
            [dateLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]]; 
            [_view addSubview:dateLabel];
            [dateLabel release];

            lastDate = newDate;

            offset += 25;

          }

          float baseAlpha = 1.0;

          //if ([object status] == EKEventStatusTentative || [object status] == EKEventStatusNone) {
          //  baseAlpha = 0.5;
          //}

          UILabel *yourLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, offset, width, 20)];
          yourLabel.alpha = baseAlpha;
          yourLabel.text = [object title];

          [yourLabel setTextColor:[UIColor whiteColor]];
          [yourLabel setBackgroundColor:[UIColor clearColor]];
          [yourLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]]; 
          [_view addSubview:yourLabel];
          [yourLabel release];

          offset += 16;

          yourLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, offset, width + 20, 20)];
          yourLabel.alpha = 0.7 * baseAlpha;
          yourLabel.text = [NSString stringWithFormat:@"%@—%@", start, end];;

          [yourLabel setTextColor:[UIColor whiteColor]];
          [yourLabel setBackgroundColor:[UIColor clearColor]];
          [yourLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 10.0f]]; 
          [_view addSubview:yourLabel];
          [yourLabel release];

          offset += 16;

          if (location) {

            offset -= 2;

            yourLabel = [[UILabel alloc] initWithFrame:CGRectMake(left, offset, width + 20, 20)];
            yourLabel.alpha = 0.7 * baseAlpha;
            yourLabel.text = location;

            [yourLabel setTextColor:[UIColor whiteColor]];
            [yourLabel setBackgroundColor:[UIColor clearColor]];
            [yourLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 10.0f]]; 
            [_view addSubview:yourLabel];
            [yourLabel release];

            offset += 16;
          
          }

          lastFingerprint = newFingerprint;

          offset += 8;
        }
      }
    }
  }

}

- (void)loadPlaceholderView {
	// This should only be a placeholder - it should not connect to any servers or perform any intense
	// data loading operations.
	//
	// All widgets are 316 points wide. Image size calculations match those of the Stocks widget.
	//_view = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, {316.f, 515.f}}];
}

- (void)unloadView {
	[_view release];
	_view = nil;
}

- (float)viewHeight {
	return 71.f;
}

@end
