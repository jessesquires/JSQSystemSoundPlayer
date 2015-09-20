//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://www.jessesquires.com/JSQSystemSoundPlayer
//
//
//  GitHub
//  https://github.com/jessesquires/JSQSystemSoundPlayer
//
//
//  License
//  Copyright (c) 2015 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

#import <JSQSystemSoundPlayer/JSQSystemSoundPlayer.h>


static NSString * const kJSQSystemSoundPlayerUserDefaultsKey = @"kJSQSystemSoundPlayerUserDefaultsKey";

static NSString * const kSoundBasso = @"Basso";
static NSString * const kSoundFunk = @"Funk";
static NSString * const kSoundBalladPiano = @"BalladPiano";


// Declare private interface here in order to test private methods
// ***************************************************************
@interface JSQSystemSoundPlayer (UnitTests)

@property (strong, nonatomic) NSMutableDictionary *sounds;
@property (strong, nonatomic) NSMutableDictionary *completionBlocks;

- (NSData *)dataWithSoundID:(SystemSoundID)soundID;

- (SystemSoundID)soundIDFromData:(NSData *)data;

- (SystemSoundID)soundIDForFilename:(NSString *)filenameKey;

- (void)addSoundIDForAudioFileWithName:(NSString *)filename
                             extension:(NSString *)ext;

- (SystemSoundID)createSoundIDWithName:(NSString *)filename
                             extension:(NSString *)ext;

- (JSQSystemSoundPlayerCompletionBlock)completionBlockForSoundID:(SystemSoundID)soundID;

- (void)addCompletionBlock:(JSQSystemSoundPlayerCompletionBlock)block
                 toSoundID:(SystemSoundID)soundID;

- (void)removeCompletionBlockForSoundID:(SystemSoundID)soundID;

@end
// ***************************************************************



@interface JSQSystemSoundPlayerTests : XCTestCase

@property (strong, nonatomic) JSQSystemSoundPlayer *soundPlayer;

@end



@implementation JSQSystemSoundPlayerTests

- (void)setUp
{
    [super setUp];
    self.soundPlayer = [[JSQSystemSoundPlayer alloc] initWithBundle:[NSBundle bundleForClass:[self class]]];
    [self.soundPlayer toggleSoundPlayerOn:YES];
}

- (void)tearDown
{
    [self.soundPlayer stopAllSounds];
    self.soundPlayer = nil;
    [super tearDown];
}

- (void)testInitAndSharedInstance
{
    XCTAssertNotNil(self.soundPlayer, @"Player should not be nil");

    JSQSystemSoundPlayer *firstPlayer = [JSQSystemSoundPlayer sharedPlayer];
    JSQSystemSoundPlayer *anotherPlayer = [JSQSystemSoundPlayer sharedPlayer];
    XCTAssertEqualObjects(firstPlayer, anotherPlayer, @"Players returned from shared instance should be equal");

    XCTAssertNotEqualObjects(self.soundPlayer, firstPlayer, @"Instance and shared instance should not be equal");

    XCTAssertNotNil(self.soundPlayer.sounds, @"Sounds dictionary should be initialized");
    XCTAssertTrue([self.soundPlayer.sounds count] == 0, @"Sounds dictionary count should be 0");

    XCTAssertNotNil(self.soundPlayer.completionBlocks, @"Completion blocks dictionary should be initialized");
    XCTAssertTrue([self.soundPlayer.completionBlocks count] == 0, @"Completion blocks dictionary count should be 0");
}

- (void)testAddingSounds
{
    [self.soundPlayer addSoundIDForAudioFileWithName:kSoundBasso extension:kJSQSystemSoundTypeAIF];
    XCTAssertTrue([self.soundPlayer.sounds count] == 1, @"Player should contain 1 cached sound");

    SystemSoundID retrievedSoundID = [self.soundPlayer soundIDForFilename:kSoundBasso];
    NSData *soundData = [self.soundPlayer dataWithSoundID:retrievedSoundID];
    XCTAssertEqualObjects([self.soundPlayer.sounds objectForKey:kSoundBasso], soundData, @"Sound data should be equal");

    [self.soundPlayer addSoundIDForAudioFileWithName:kSoundBasso extension:kJSQSystemSoundTypeAIF];
    XCTAssertTrue([self.soundPlayer.sounds count] == 1, @"Player should still contain 1 only cached sound");
}

- (void)testAddingSoundsError
{
    [self.soundPlayer addSoundIDForAudioFileWithName:@"does not exist" extension:kJSQSystemSoundTypeAIF];
    XCTAssertTrue([self.soundPlayer.sounds count] == 0, @"Player should not contain any cached sounds");
}

- (void)testCompletionBlocks
{
    SystemSoundID soundID = [self.soundPlayer createSoundIDWithName:kSoundBasso extension:kJSQSystemSoundTypeAIF];
    NSData *data = [self.soundPlayer dataWithSoundID:soundID];

    JSQSystemSoundPlayerCompletionBlock block = ^{
        NSLog(@"Completion block");
    };

    [self.soundPlayer addCompletionBlock:block toSoundID:soundID];
    XCTAssertTrue([self.soundPlayer.completionBlocks count] == 1, @"Player should contain 1 cached completion blocks");
    XCTAssertEqualObjects(block, [self.soundPlayer.completionBlocks objectForKey:data], @"Blocks should be equal");
    XCTAssertEqualObjects(block, [self.soundPlayer completionBlockForSoundID:soundID], @"Blocks should be equal");

    [self.soundPlayer removeCompletionBlockForSoundID:soundID];
    XCTAssertTrue([self.soundPlayer.completionBlocks count] == 0, @"Player should contain 0 cached completion blocks");
    XCTAssertNil([self.soundPlayer.completionBlocks objectForKey:data], @"Blocks should be nil");
    XCTAssertNil([self.soundPlayer completionBlockForSoundID:soundID], @"Blocks should be nil");
}

- (void)testCreatingAndRetrievingSounds
{
    SystemSoundID soundID = [self.soundPlayer createSoundIDWithName:kSoundBasso extension:kJSQSystemSoundTypeAIF];
    XCTAssert(soundID, @"SoundID should not be nil");

    [self.soundPlayer addSoundIDForAudioFileWithName:kSoundBasso extension:kJSQSystemSoundTypeAIF];
    SystemSoundID retrievedSoundID = [self.soundPlayer soundIDForFilename:kSoundBasso];
    XCTAssert(retrievedSoundID, @"SoundID should not be nil");

    NSData *soundData = [self.soundPlayer dataWithSoundID:retrievedSoundID];
    XCTAssertNotNil(soundData, @"Sound data should not be nil");

    SystemSoundID soundIDFromData = [self.soundPlayer soundIDFromData:soundData];
    XCTAssert(soundIDFromData, @"SoundID should not be nil");
    XCTAssertEqual(soundIDFromData, retrievedSoundID, @"SoundIDs should be equal");

    SystemSoundID nilSound = [self.soundPlayer createSoundIDWithName:@"" extension:@""];
    XCTAssert(!nilSound, @"SoundID should be nil");

    SystemSoundID retrievedNilSoundID = [self.soundPlayer soundIDForFilename:@""];
    XCTAssert(!retrievedNilSoundID, @"SoundID should be nil");
}

- (void)testPlayingSounds
{
    XCTAssertNoThrow([self.soundPlayer playSoundWithFilename:kSoundBasso
                                               fileExtension:kJSQSystemSoundTypeAIF
                                                  completion:^{
                                                      NSLog(@"Completion block...");
                                                  }],
                     @"Player should play sound and not throw");

    XCTAssertNoThrow([self.soundPlayer playSoundWithFilename:kSoundFunk
                                               fileExtension:kJSQSystemSoundTypeAIFF
                                                  completion:nil],
                     @"Player should play sound and not throw");

    XCTAssertNoThrow([self.soundPlayer playAlertSoundWithFilename:kSoundBasso
                                                    fileExtension:kJSQSystemSoundTypeAIF
                                                       completion:nil],
                     @"Player should play alert and not throw");

    XCTAssertNoThrow([self.soundPlayer playAlertSoundWithFilename:kSoundFunk
                                                    fileExtension:kJSQSystemSoundTypeAIFF
                                                       completion:nil],
                     @"Player should play alert and not throw with nil block");

    XCTAssertNoThrow([self.soundPlayer playAlertSoundWithFilename:kSoundBalladPiano
                                                    fileExtension:kJSQSystemSoundTypeAIFF
                                                       completion:nil],
                     @"Player should fail gracefully and not throw on incorrect extension");

    XCTAssertNoThrow([self.soundPlayer playVibrateSound], @"Player should vibrate and not throw");
}

- (void)testStoppingSounds
{
    [self.soundPlayer playSoundWithFilename:kSoundBasso fileExtension:kJSQSystemSoundTypeAIF completion:nil];
    [self.soundPlayer playSoundWithFilename:kSoundBalladPiano fileExtension:kJSQSystemSoundTypeCAF completion:nil];

    XCTAssertTrue([self.soundPlayer.sounds count] == 2, @"Player should have 2 sounds cached");

    [self.soundPlayer stopSoundWithFilename:kSoundBalladPiano];
    XCTAssertTrue([self.soundPlayer.sounds count] == 1, @"Player should have 1 sound cached");
}

// Disabled because Travis-ci is derpy :(
- (void)DISABLED_testSoundCompletionBlocks
{
    [self.soundPlayer toggleSoundPlayerOn:YES];

    XCTestExpectation *expectation = [self expectationWithDescription:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__]];

    [self.soundPlayer playSoundWithFilename:kSoundBasso
                              fileExtension:kJSQSystemSoundTypeAIF
                                 completion:^{
                                     [expectation fulfill];
                                 }];

    [self waitForExpectationsWithTimeout:10 handler:^(NSError * __nullable error) {
        XCTAssertNil(error, @"Expectation should not error");
    }];
}

- (void)testMemoryWarning
{
    [self.soundPlayer playSoundWithFilename:kSoundBasso
                              fileExtension:kJSQSystemSoundTypeAIF
                                 completion:^{
                                     NSLog(@"Completion block...");
                                 }];

    XCTAssertTrue([self.soundPlayer.completionBlocks count] == 1, @"Completion blocks dictionary should contain 1 object");

    [self.soundPlayer playAlertSoundWithFilename:kSoundFunk
                                   fileExtension:kJSQSystemSoundTypeAIFF
                                      completion:nil];

    XCTAssertTrue([self.soundPlayer.sounds count] == 2, @"Sounds dictionary should contain 2 objects");

    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification
                                                        object:nil];

    XCTAssertTrue([self.soundPlayer.sounds count] == 0, @"Sounds should have been purged on memory warning");
    XCTAssertTrue([self.soundPlayer.completionBlocks count] == 0, @"Completion blocks should have been purged on memory warning");
}

- (void)testUserDefaultsSettings
{
    BOOL soundPlayerOn = self.soundPlayer.on;
    BOOL soundSetting = [[[NSUserDefaults standardUserDefaults] objectForKey:kJSQSystemSoundPlayerUserDefaultsKey] boolValue];
    XCTAssertEqual(soundPlayerOn, soundSetting, @"Sound setting values should be equal");

    [self.soundPlayer toggleSoundPlayerOn:NO];
    soundPlayerOn = self.soundPlayer.on;
    soundSetting = [[[NSUserDefaults standardUserDefaults] objectForKey:kJSQSystemSoundPlayerUserDefaultsKey] boolValue];
    XCTAssertEqual(soundPlayerOn, soundSetting, @"Sound setting values should be equal");

    [self.soundPlayer toggleSoundPlayerOn:YES];
    soundPlayerOn = self.soundPlayer.on;
    soundSetting = [[[NSUserDefaults standardUserDefaults] objectForKey:kJSQSystemSoundPlayerUserDefaultsKey] boolValue];
    XCTAssertEqual(soundPlayerOn, soundSetting, @"Sound setting values should be equal");
}

- (void)testPreloadSounds
{
    XCTAssertTrue([self.soundPlayer.sounds count] == 0, @"Player should begin with no sounds");

    [self.soundPlayer preloadSoundWithFilename:kSoundBasso fileExtension:kJSQSystemSoundTypeAIF];

    XCTAssertTrue([self.soundPlayer.sounds count] == 1, @"Player should have 1 sound after preloading");
    XCTAssert([self.soundPlayer soundIDForFilename:kSoundBasso], @"Player soundID for file should not be 0");
}

- (void)testPlayingInvalidSoundfileError
{
    XCTAssertNoThrow([self.soundPlayer playSoundWithFilename:@"Does not exist"
                                               fileExtension:kJSQSystemSoundTypeAIFF
                                                  completion:nil],
                     @"Player should play sound and not throw");
}

- (void)testPlayingSoundWhenPlayerIsOff
{
    [self.soundPlayer toggleSoundPlayerOn:NO];
    XCTAssertNoThrow([self.soundPlayer playSoundWithFilename:kSoundFunk
                                               fileExtension:kJSQSystemSoundTypeAIFF
                                                  completion:nil],
                     @"Player should ignore playing sound and not throw");
}

@end
