//
//  SoundPlayerDemoTests.m
//  SoundPlayerDemoTests
//
//  Created by Jesse Squires on 11/14/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JSQSystemSoundPlayer.h"


// Declare private interface here in order to test private methods
// ***************************************************************
@interface JSQSystemSoundPlayer (UnitTests)

@property (strong, nonatomic) NSMutableDictionary *sounds;

- (SystemSoundID)soundIDForFilename:(NSString *)filenameKey;

- (void)addSoundIDForAudioFileWithName:(NSString *)filename
                             extension:(NSString *)ext;

- (SystemSoundID)createSoundIDWithName:(NSString *)filename
                             extension:(NSString *)ext;

- (void)unloadSoundIDs;

- (void)didReceiveMemoryWarningNotification:(NSNotification *)notification;

@end
// ***************************************************************



@interface SoundPlayerDemoTests : XCTestCase

@property (strong, nonatomic) JSQSystemSoundPlayer *player;
@property (copy, nonatomic) NSString *filename;

@end



@implementation SoundPlayerDemoTests

- (void)setUp
{
    [super setUp];
    self.player = [JSQSystemSoundPlayer sharedPlayer];
    self.filename = @"Basso";
}

- (void)tearDown
{
    self.player = nil;
    self.filename = nil;
    [super tearDown];
}

- (void)testInitAndSharedInstance
{
    XCTAssertNotNil(self.player, @"Player should not be nil.");
    
    JSQSystemSoundPlayer *anotherPlayer = [JSQSystemSoundPlayer sharedPlayer];
    XCTAssertEqualObjects([JSQSystemSoundPlayer sharedPlayer], anotherPlayer, @"Players returned from shared instance should be equal.");
}

- (void)testAddingSounds
{
    XCTAssert(self.player.sounds, @"Sounds dictionary should be initialized");
    XCTAssertEqual(0ul, [self.player.sounds count], @"Sounds dictionary count should be 0.");
    
    [self.player addSoundIDForAudioFileWithName:self.filename extension:kJSQSystemSoundTypeAIF];
    XCTAssertEqual(1ul, [self.player.sounds count], @"Player should contain 1 cached sound.");
    
    [self.player addSoundIDForAudioFileWithName:self.filename extension:kJSQSystemSoundTypeAIF];
    XCTAssertEqual(1ul, [self.player.sounds count], @"Player should still contain 1 only cached sound.");
}

- (void)testCreatingSounds
{
    SystemSoundID nilSound = [self.player createSoundIDWithName:@"" extension:@""];
    XCTAssertEqual(0u, nilSound, @"SoundID should be zero.");
    
    SystemSoundID soundID = [self.player createSoundIDWithName:self.filename extension:kJSQSystemSoundTypeAIF];
    XCTAssertNotEqual(0u, soundID, @"SoundID should not be zero.");
}

- (void)testRetrievingSounds
{
    XCTAssertEqual(0u, [self.player soundIDForFilename:@"missing"], @"should be 0 for missing file");
    
    [self.player addSoundIDForAudioFileWithName:self.filename extension:kJSQSystemSoundTypeAIF];
    XCTAssertNotEqual(0u, [self.player soundIDForFilename:self.filename], @"should have be valid SoundID for existing file");
}

- (void)testVibrate
{
    XCTAssertNoThrow([self.player vibrate], @"should vibrate device and not throw an exception");
}

- (void)testStopAllSoundsImmediately
{
    [self.player addSoundIDForAudioFileWithName:self.filename extension:kJSQSystemSoundTypeAIF];
    XCTAssertEqual(1ul, [self.player.sounds count], @"should have 1 sound loaded");
    
    XCTAssertNoThrow([self.player stopAllSoundsImmediately], @"should not throw an exception");
    XCTAssertEqual(0ul, [self.player.sounds count], @"should have all sounds unloaded");
}


- (void)testMemoryWarning
{
    [self.player addSoundIDForAudioFileWithName:self.filename extension:kJSQSystemSoundTypeAIF];
    XCTAssertEqual(1ul, [self.player.sounds count], @"should have 1 sound loaded");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification
                                                        object:self];
    XCTAssertEqual(0ul, [self.player.sounds count], @"Sounds should have been purged on memory warning.");
}

@end
