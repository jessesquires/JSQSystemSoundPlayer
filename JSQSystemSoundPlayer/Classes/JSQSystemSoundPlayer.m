//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import "JSQSystemSoundPlayer.h"

#import <AudioToolbox/AudioToolbox.h>

NSString * const kJSQSystemSoundTypeCAF = @"caf";
NSString * const kJSQSystemSoundTypeAIF = @"aif";
NSString * const kJSQSystemSoundTypeAIFF = @"aiff";
NSString * const kJSQSystemSoundTypeWAV = @"wav";

@interface JSQSystemSoundPlayer ()

@property (strong, nonatomic) NSMutableDictionary *sounds;

- (void)playSoundWithName:(NSString *)filename
                extension:(NSString *)extension
                  isAlert:(BOOL)isAlert;

- (SystemSoundID)soundIDForFilename:(NSString *)filenameKey;

- (void)addSoundIDForAudioFileWithName:(NSString *)filename
                             extension:(NSString *)extension;

- (SystemSoundID)createSoundIDWithName:(NSString *)filename
                             extension:(NSString *)extension;

- (void)unloadSoundIDs;

- (void)didReceiveMemoryWarningNotification:(NSNotification *)notification;

@end



@implementation JSQSystemSoundPlayer

#pragma mark - Init

+ (JSQSystemSoundPlayer *)sharedPlayer
{
    static JSQSystemSoundPlayer *sharedPlayer;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedPlayer = [[JSQSystemSoundPlayer alloc] init];
    });
    
    return sharedPlayer;
}

- (id)init
{
    self = [super init];
    if(self) {
        _sounds = [[NSMutableDictionary alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMemoryWarningNotification:)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [self unloadSoundIDs];
    _sounds = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidReceiveMemoryWarningNotification
                                                  object:nil];
}

#pragma mark - Sounds

- (void)playSoundWithName:(NSString *)filename
                extension:(NSString *)extension
                  isAlert:(BOOL)isAlert
{
    if(!filename || !extension) {
        return;
    }
    
    if(![self.sounds objectForKey:filename]) {
        NSLog(@"Need to add sound: %@.%@", filename, extension);
        [self addSoundIDForAudioFileWithName:filename extension:extension];
    }

    SystemSoundID soundID = [self soundIDForFilename:filename];
    if(soundID) {
        if(isAlert) {
            AudioServicesPlayAlertSound(soundID);
        }
        else {
            AudioServicesPlaySystemSound(soundID);
        }
    }
}

- (void)playSoundWithName:(NSString *)filename extension:(NSString *)extension
{
    [self playSoundWithName:filename
                  extension:extension
                    isAlert:NO];
}

- (void)playAlertSoundWithName:(NSString *)filename extension:(NSString *)extension
{
    [self playSoundWithName:filename
                  extension:extension
                    isAlert:YES];
}

- (void)playVibrateSound
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

#pragma mark - Utilities

- (SystemSoundID)soundIDForFilename:(NSString *)filenameKey
{
    NSData *soundData = [self.sounds objectForKey:filenameKey];
    SystemSoundID soundID;
    [soundData getBytes:&soundID length:sizeof(SystemSoundID)];
    return soundID;
}

- (void)addSoundIDForAudioFileWithName:(NSString *)filename
                             extension:(NSString *)extension
{
    SystemSoundID soundID = [self createSoundIDWithName:filename
                                              extension:extension];
    if(soundID) {
        NSData *data = [NSData dataWithBytes:&soundID length:sizeof(SystemSoundID)];
        [self.sounds setObject:data forKey:filename];
    }
}

- (SystemSoundID)createSoundIDWithName:(NSString *)filename
                             extension:(NSString *)extension
{
    NSLog(@"Creating soundID for %@.%@", filename, extension);

    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename
                                             withExtension:extension];

    if([[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]]) {
        SystemSoundID soundID;
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &soundID);

        if(error) {
            NSLog(@"AudioServicesCreateSystemSoundID error code: %d", (int)error);
            return 0;
        }
        else {
            NSLog(@"Create soundID success");
            return soundID;
        }
    }

    NSLog(@"Error: audio file not found at URL: %@", fileURL);
    return 0;
}

- (void)unloadSoundIDs
{
    NSLog(@"Unloading sound IDs");

    for(NSString *eachFilename in [_sounds allKeys]) {
        SystemSoundID soundID = [self soundIDForFilename:eachFilename];
        if(soundID) {
            AudioServicesDisposeSystemSoundID(soundID);
        }
    }
    
    [_sounds removeAllObjects];
}

#pragma mark - Notifications

- (void)didReceiveMemoryWarningNotification:(NSNotification *)notification
{
    NSLog(@"%@ received memory warning", [self class]);
    [self unloadSoundIDs];
}

@end
