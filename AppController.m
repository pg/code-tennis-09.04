//
//  AppController.m
//  Match1
//
//  Created by Jeff Stieler on 4/2/09.
//  Copyright 2009 VolleyApps. All rights reserved.
//

#import "AppController.h"


@implementation AppController

- (id)init {
	[super init];
	NSLog(@"init AppController");
		
	// Create instance of NSSpeechSynthesizer with the default voice
	speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:nil];
	// Pete: gotta set the delegate of the NSSpeechSynthesize to self so it calls the
	// "didFinishSpeaking" method when it's done yapping
	[speechSynth setDelegate:self];
	NSLog(@"init NSSpeechSynth");
	
	// Build list of feeds (hard-coded for now, unfortunately)
	NSArray *feedNames = [NSArray arrayWithObjects:@"Hacker News", @"MacRumors", nil];	
	NSArray *feedURLs = [NSArray arrayWithObjects:@"http://news.ycombinator.com/rss", @"http://www.macrumors.com/macrumors.xml", nil];	
	feedDictionary = [NSDictionary dictionaryWithObjects:feedURLs forKeys:feedNames];
	NSLog(@"init Feed Dictionary");
	
	client = [PSClient applicationClient];
	
	// TODO: Add feed names to popupButton
	//[popupButton addItemsWithTitles:feedNames];	
	//NSLog(@"init Names added to popupButton");

	return self;
}

- (IBAction)readFeedAloud:(id)sender {
	NSLog(@"button clicked");
	
	// TODO: Use something like this to grab the URL from the popupButton list, 
	//       but I couldn't seem to get the objectForKey method to work.
	//NSString *str = [feedDictionary objectForKey:[popupButton titleOfSelectedItem]];	
	//NSLog(@"feedDictionary objectForKey - %@", str);
	
	// Grab feed from selected URL
	feedURL = [NSURL URLWithString:@"http://news.ycombinator.com/rss"];	
	NSLog(@"Selected feed URL - %@", feedURL);
	
	feed = [client addFeedWithURL:feedURL];
	NSLog(@"Feed added - %@", feedURL-);
	
	// Go through entries in feed
	NSEnumerator * entries = [feed entryEnumeratorSortedBy: nil];
	PSEntry *entry;
	
	// TODO: Control entry processing rate to give time for speaking (use didFinishSpeaking delegate?)
	while(entry = [entries nextObject]) {
		// Send the entry to the speech synth
		[speechSynth startSpeakingString:entry.title];
		NSLog(@"Entry Title:%@", entry.title);
	}	
		
	[goButton setEnabled:NO];
	//[feed release];
}

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender 
		didFinishSpeaking:(BOOL)complete {
	NSLog(@"speaking complete = %d", complete);
	[goButton setEnabled:YES];
}

@end
