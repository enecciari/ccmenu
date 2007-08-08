
#import "CCMImageFactory.h"
#import "CCMProject.h"


@implementation CCMImageFactory

- (NSImage *)imageNamed:(NSString *)name
{
	NSImage *image = [NSImage imageNamed:name];
	if(image == nil)
	{
		// This is a hack to make the unit tests work, in which imageNamed: doesn't work
		NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"Images/%@", name]];
		image = [[NSImage alloc] initWithContentsOfURL:url];
		[image setName:name];
	}
	return image;	
}

- (NSImage *)imageForActivity:(NSString *)activity lastBuildStatus:(NSString *)status
{
	activity = [activity isEqualToString:CCMBuildingActivity] ? @"-building" : @"";
	status = [status lowercaseString];
	NSString *name = [NSString stringWithFormat:@"icon-%@%@.png", status, activity];
	return [self imageNamed:name];
}

- (NSImage *)imageForUnavailableServer
{
	return [self imageNamed:@"icon-inactive.png"];
}

- (NSImage *)convertForMenuUse:(NSImage *)originalImage
{
	NSString *name = [NSString stringWithFormat:@"%@-menu", [originalImage name]];
	NSImage *menuImage = [NSImage imageNamed:name];
	if(menuImage == nil)
	{
		menuImage = [[originalImage copy] autorelease];
		[menuImage setScalesWhenResized:NO];
		[menuImage setSize:NSMakeSize(15, 17)];
		[menuImage setName:name];
	}
	return menuImage;
}

@end