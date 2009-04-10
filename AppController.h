//
//  AppController.h
//  Match1
//
//  Created by Jeff Stieler on 4/2/09.
//  Copyright 2009 VolleyApps. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <PubSub/PubSub.h>


@interface AppController : NSObject {
	IBOutlet NSButton *goButton;
	IBOutlet NSPopUpButton *popupButton;
	NSSpeechSynthesizer *speechSynth;
	NSDictionary *feedDictionary;
	NSURL *feedURL;
	PSFeed *feed;
	PSClient *client;
}
- (IBAction)readFeedAloud:(id)sender;

@end
