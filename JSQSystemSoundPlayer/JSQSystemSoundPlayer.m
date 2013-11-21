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

NSString * const kJSQSystemSoundTypeCAF = @"caf";
NSString * const kJSQSystemSoundTypeAIF = @"aif";
NSString * const kJSQSystemSoundTypeWAV = @"wav";

@interface JSQSystemSoundPlayer ()

@property (strong, nonatomic) NSMutableDictionary *sounds;

- (SystemSoundID)soundIDForFilename:(NSString *)filenameKey;
- (void)addSoundIDForAudioFileWithName:(NSString *)filename
                             extension:(NSString *)ext;
- (SystemSoundID)createSoundIDWithName:(NSString *)filename
                             extension:(NSString *)ext;
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

- (void)playSoundWithName:(NSString *)filename extension:(NSString *)ext
{
    if(![self.sounds objectForKey:filename]) {
        NSLog(@"Need to add sound: %@.%@", filename, ext);
        [self addSoundIDForAudioFileWithName:filename extension:ext];
    }

    SystemSoundID soundID = [self soundIDForFilename:filename];
    if(soundID) {
        AudioServicesPlaySystemSound(soundID);
    }
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
                             extension:(NSString *)ext
{
    SystemSoundID soundID = [self createSoundIDWithName:filename extension:ext];
    if(soundID) {
        NSData *data = [NSData dataWithBytes:&soundID length:sizeof(SystemSoundID)];
        [self.sounds setObject:data forKey:filename];
    }
}

- (SystemSoundID)createSoundIDWithName:(NSString *)filename
                             extension:(NSString *)ext
{
    NSLog(@"Creating soundID for %@.%@", filename, ext);

    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:ext];

    if([[NSFileManager defaultManager] fileExistsAtPath:[fileURL path]]) {
        SystemSoundID soundID;
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &soundID);

        if(error) {
            NSLog(@"AudioServicesCreateSystemSoundID error code: %d", (NSInteger)error);
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
