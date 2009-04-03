//
//  AppController.m
//  Match1
//
//  Created by Jeff Stieler on 4/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"


@implementation AppController

- (id)init {
	[super init];
	NSLog(@"init AppController");
	
	// Seed the random number generator
	srandom(time(NULL));
	NSLog(@"random num gen seeded");
	
	// Create instance of NSSpeechSynthesizer with the default voice
	speechSynth = [[NSSpeechSynthesizer alloc] initWithVoice:nil];
	// Pete: gotta set the delegate of the NSSpeechSynthesize to self so it calls the
	// "didFinishSpeaking" method when it's done yapping
	[speechSynth setDelegate:self];
	NSLog(@"init NSSpeechSynth");
	
	// Setup the 8-Ball responses array (Sourced from the mighty Wikipedia)
	responses = [[NSArray alloc] initWithObjects:@"As I see it, yes.", @"It is certain.", 
				 @"It is decidedly so.", @"Most likely.", @"Outlook good.", @"Signs point to yes.", 
				 @"Without a doubt.", @"Yes.", @"Yes - definitely.", @"You may rely on it.", 
				 @"Reply hazy, try again.", @"Ask again later.", @"Better not tell you now.", 
				 @"Cannot predict now.", @"Concentrate and ask again.", @"Don't count on it.", 
				 @"My reply is no.", @"My sources say no.", @"Outlook not so good.", 
				 @"Very doubtful.", nil];
	NSLog(@"set 8-Ball responses");
	return self;
}

- (IBAction)giveMagicEightBallAnswer:(id)sender {
	NSLog(@"button clicked");
	
	// Pick a random string from responses array
	int rand = random() % [responses count];
	NSString *response = [responses objectAtIndex:rand];
	NSLog(@"Chose response #%d - %@", rand, response);
	
	// Set the label text
	[textField setStringValue:response];
	
	// Send the response to the speech synth
	[speechSynth startSpeakingString:response];
	NSLog(@"Have started to say: %@", response);
	[goButton setEnabled:NO];
	[response release];
}

- (void)speechSynthesizer:(NSSpeechSynthesizer *)sender 
		didFinishSpeaking:(BOOL)complete {
	NSLog(@"speaking complete = %d", complete);
	[textField setStringValue:@""];
	[goButton setEnabled:YES];
}

@end
