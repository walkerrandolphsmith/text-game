//
//  SpeechCenter.m
//  StarterGame
//
//  Created by Jacob Bernett on 4/19/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//


#import "SpeechCenter.h"

@implementation SpeechCenter

-(id)init
{
    self = [super init];
    
	if (nil != self) {
        StatementsArray = [[NSMutableArray alloc]init];
        sessionIsActive = YES;
        speaking = NO;
        
        speechSynthesizer = [[NSSpeechSynthesizer alloc]init];
        [speechSynthesizer setDelegate:self];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionBecameActive:) name:@"sessionBecameActiveNotification" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionBecameInactive:) name:@"sessionBecameInactiveNotification" object:nil];
          [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionMuteBecameToggled:) name:@"sessionMuteBecameToggledNotification" object:nil];
    }
    return self;
}

-(void)prepareSpeech:(NSString *)text
{
    if(text){
        if([text length] && sessionIsActive){
            [StatementsArray addObject:text];
            [self speak];
        }
    }
}
-(void)speak
{
    if([StatementsArray count] && !speaking){
            speaking = YES;
            [speechSynthesizer startSpeakingString:[StatementsArray objectAtIndex:0]];
            [StatementsArray removeObjectAtIndex:0];
    }
}

-(void)haltSpeaking
{
    [StatementsArray removeAllObjects];
    [speechSynthesizer stopSpeaking];
}

-(void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking
{
    speaking = NO;
    [self speak];
}

-(void)sessionMuteBecameToggled:(NSNotification *)notification
{
    if(speaking){
        [speechSynthesizer stopSpeaking];
    }
    sessionIsActive = !sessionIsActive;
}

-(void)sessionBecameActive:(NSNotification *)notification
{
    NSString *words = [[notification userInfo]objectForKey:@"wordsToBeSpoken"];
    //NSLog(words);
    [self prepareSpeech:words];
}

-(void)sessionBecameInactive:(NSNotification *)notification
{
    sessionIsActive = NO;
    [self haltSpeaking];
}

-(void)dealloc
{    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    [super dealloc];
}

@end
