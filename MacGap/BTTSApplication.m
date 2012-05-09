//
//  BTTSApplication.m
//  MacGap
//
//  Created by Nate Wienert on 5/8/12.
//  Copyright 2012 Twitter. All rights reserved.
//

#import "WebViewDelegate.h"
#import "BTTSApplication.h"

#import <AppKit/NSEvent.h>
#import <IOKit/hidsystem/ev_keymap.h>

@implementation BTTSApplication

@synthesize windowController;


/* These are the same bits found in event modifier flags    */
enum {
   	MKNoModKey = 0,
   	MKShift    = NSShiftKeyMask,
    MKControl  = NSControlKeyMask,
    MKOption   = NSAlternateKeyMask,
    MKCommand  = NSCommandKeyMask,
};


- (void)mediaKeyEvent: (int)key modifier:(int)mod state: (BOOL)state repeat: (BOOL)repeat
{
	// Ignore all event except key down
	if( state != 0 ) return;
	
	switch( mod )
	{
            // No modifier key
		case MKNoModKey:
            switch( key )
		{
			case NX_KEYTYPE_PLAY:
				; //Play pressed
				printf("%s\n","PLAY");
                [[[NSWorkspace sharedWorkspace] notificationCenter] postNotificationName:@"playNotification" object:nil];
				break;
                
			case NX_KEYTYPE_NEXT:
			case NX_KEYTYPE_FAST:
				; //Next pressed or held
				printf("%s\n","NEXT");
                [[[NSWorkspace sharedWorkspace] notificationCenter] postNotificationName:@"nextNotification" object:nil];
				break;
                
			case NX_KEYTYPE_PREVIOUS:
			case NX_KEYTYPE_REWIND:
				; //Previous pressed or held
				printf("%s\n","PREV");
                [[[NSWorkspace sharedWorkspace] notificationCenter] postNotificationName:@"prevNotification" object:nil];
				break;
		}
            break;
	}
}

- (void)sendEvent: (NSEvent*)event
{
	if( [event type] == NSSystemDefined && [event subtype] == 8 )
	{
		int keyCode = (([event data1] & 0xFFFF0000) >> 16);
		int keyFlags = ([event data1] & 0x0000FFFF);
		int keyState = (((keyFlags & 0xFF00) >> 8)) ==0xA;
		int keyRepeat = (keyFlags & 0x1);
		
		int modifierKey = 0;
		[self mediaKeyEvent: keyCode modifier: modifierKey state: keyState repeat: keyRepeat];
	}
	[super sendEvent: event];
}
@end
