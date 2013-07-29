//
//  SpeechCenter.h
//  StarterGame
//
//  Created by Jacob Bernett on 4/19/13.
//  Copyright (c) 2013 Ringtuple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpeechCenter : NSObject<NSSpeechSynthesizerDelegate>{
    NSMutableArray *StatementsArray;
    NSSpeechSynthesizer *speechSynthesizer;
    
    BOOL sessionIsActive;
    BOOL speaking;
}

-(void)prepareSpeech:(NSString *)text;
-(void)speak;
-(void)haltSpeaking;

-(void)speechSynthesizer:(NSSpeechSynthesizer *)sender didFinishSpeaking:(BOOL)finishedSpeaking;

-(void)sessionBecameActive:(NSNotification *)notification;
-(void)sessionBecameInactive:(NSNotification *)notification
;


@end
