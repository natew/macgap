//
//  MediaKeys.h
//  MediaKeys
//
//  Created by id on 06/01/2010.
//  Copyright 2010 dreamcat4. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "WindowController.h"

@interface BTTSApplication : NSApplication
{
}

@property (retain, nonatomic) WindowController *windowController;

@end
