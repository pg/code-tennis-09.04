//
//  AppController.h
//  Match1
//
//  Created by Jeff Stieler on 4/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	IBOutlet NSButton *goButton;
	IBOutlet NSTextField *textField;
	NSArray *responses;
	NSSpeechSynthesizer *speechSynth;
}
- (IBAction)giveMagicEightBallAnswer:(id)sender;

@end
