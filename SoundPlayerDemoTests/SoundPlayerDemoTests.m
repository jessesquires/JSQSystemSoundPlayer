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

@property (strong, nonatomic) JSQSystemSoundPlayer *sharedPlayer;
@property (copy, nonatomic) NSString *filename;

@end



@implementation SoundPlayerDemoTests

- (void)setUp
{
    [super setUp];
    _sharedPlayer = [JSQSystemSoundPlayer sharedPlayer];
    _filename = @"Basso";
}

- (void)tearDown
{
    _sharedPlayer = nil;
    _filename = nil;
    [super tearDown];
}

- (void)testInitAndSharedInstance
{
    XCTAssertNotNil(self.sharedPlayer, @"Player should not be nil.");
    
    JSQSystemSoundPlayer *anotherPlayer = [JSQSystemSoundPlayer sharedPlayer];
    XCTAssertEqualObjects(self.sharedPlayer, anotherPlayer, @"Players returned from shared instance should be equal.");
}

- (void)testAddingSounds
{
    XCTAssert(self.sharedPlayer.sounds, @"Sounds dictionary should be initialized");
    XCTAssertTrue([self.sharedPlayer.sounds count] == 0, @"Sounds dictionary count should be 0.");
    
    [self.sharedPlayer addSoundIDForAudioFileWithName:self.filename extension:kJSQSystemSoundTypeAIF];
    XCTAssertTrue([self.sharedPlayer.sounds count] == 1, @"Player should contain 1 cached sound.");
    
    [self.sharedPlayer addSoundIDForAudioFileWithName:self.filename extension:kJSQSystemSoundTypeAIF];
    XCTAssertTrue([self.sharedPlayer.sounds count] == 1, @"Player should still contain 1 only cached sound.");
}

- (void)testCreatingSounds
{
    SystemSoundID soundID = [self.sharedPlayer createSoundIDWithName:self.filename extension:kJSQSystemSoundTypeAIF];
    XCTAssert(soundID, @"SoundID should not be nil.");
 
    SystemSoundID nilSound = [self.sharedPlayer createSoundIDWithName:@"" extension:@""];
    XCTAssert(!nilSound, @"SoundID should be nil.");
}

- (void)testRetrievingSounds
{
    [self.sharedPlayer addSoundIDForAudioFileWithName:self.filename extension:kJSQSystemSoundTypeAIF];
    SystemSoundID retrievedSoundID = [self.sharedPlayer soundIDForFilename:self.filename];
    XCTAssert(retrievedSoundID, @"SoundID should not be nil");
}

- (void)testVibrate
{
    XCTAssertNoThrow([self.sharedPlayer vibrate], @"should vibrate device and not throw an exception");
}


- (void)testMemoryWarning
{

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [[UIApplication sharedApplication] performSelector:@selector(_performMemoryWarning)];
#pragma clang diagnostic pop
    
    XCTAssertTrue([self.sharedPlayer.sounds count] == 0, @"Sounds should have been purged on memory warning.");
}

@end
