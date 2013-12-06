//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <XCTest/XCTest.h>
#import <AudioToolbox/AudioToolbox.h>
#import "JSQSystemSoundPlayer.h"


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

@property (strong, nonatomic) JSQSystemSoundPlayer *sharedPlayer;
@property (copy, nonatomic) NSString *filename;

@end



@implementation JSQSystemSoundPlayerTests

- (void)setUp
{
    [super setUp];
    _sharedPlayer = [JSQSystemSoundPlayer sharedPlayer];
    _filename = @"Basso";
}

- (void)tearDown
{
    [_sharedPlayer stopAllSounds];
    _sharedPlayer = nil;
    _filename = nil;
    [super tearDown];
}

- (void)testInitAndSharedInstance
{
    XCTAssertNotNil(self.sharedPlayer, @"Player should not be nil");
    
    JSQSystemSoundPlayer *anotherPlayer = [JSQSystemSoundPlayer sharedPlayer];
    XCTAssertEqualObjects(self.sharedPlayer, anotherPlayer, @"Players returned from shared instance should be equal");
    
    XCTAssertNotNil(self.sharedPlayer.sounds, @"Sounds dictionary should be initialized");
    XCTAssertTrue([self.sharedPlayer.sounds count] == 0, @"Sounds dictionary count should be 0");
    
    XCTAssertNotNil(self.sharedPlayer.completionBlocks, @"Completion blocks dictionary should be initialized");
    XCTAssertTrue([self.sharedPlayer.completionBlocks count] == 0, @"Completion blocks dictionary count should be 0");
}

- (void)testAddingSounds
{
    [self.sharedPlayer addSoundIDForAudioFileWithName:self.filename extension:kJSQSystemSoundTypeAIF];
    XCTAssertTrue([self.sharedPlayer.sounds count] == 1, @"Player should contain 1 cached sound");
    
    SystemSoundID retrievedSoundID = [self.sharedPlayer soundIDForFilename:self.filename];
    NSData *soundData = [self.sharedPlayer dataWithSoundID:retrievedSoundID];
    XCTAssertEqualObjects([self.sharedPlayer.sounds objectForKey:self.filename], soundData, @"Sound data should be equal");
    
    [self.sharedPlayer addSoundIDForAudioFileWithName:self.filename extension:kJSQSystemSoundTypeAIF];
    XCTAssertTrue([self.sharedPlayer.sounds count] == 1, @"Player should still contain 1 only cached sound");
}

- (void)testCompletionBlocks
{
    SystemSoundID soundID = [self.sharedPlayer createSoundIDWithName:self.filename extension:kJSQSystemSoundTypeAIF];
    NSData *data = [self.sharedPlayer dataWithSoundID:soundID];
    
    JSQSystemSoundPlayerCompletionBlock block = ^{
        NSLog(@"Completion block");
    };
    
    [self.sharedPlayer addCompletionBlock:block toSoundID:soundID];
    XCTAssertTrue([self.sharedPlayer.completionBlocks count] == 1, @"Player should contain 1 cached completion blocks");
    XCTAssertEqualObjects(block, [self.sharedPlayer.completionBlocks objectForKey:data], @"Blocks should be equal");
    XCTAssertEqualObjects(block, [self.sharedPlayer completionBlockForSoundID:soundID], @"Blocks should be equal");
    
    [self.sharedPlayer removeCompletionBlockForSoundID:soundID];
    XCTAssertTrue([self.sharedPlayer.completionBlocks count] == 0, @"Player should contain 0 cached completion blocks");
    XCTAssertNil([self.sharedPlayer.completionBlocks objectForKey:data], @"Blocks should be nil");
    XCTAssertNil([self.sharedPlayer completionBlockForSoundID:soundID], @"Blocks should be nil");
}

- (void)testCreatingSounds
{
    SystemSoundID soundID = [self.sharedPlayer createSoundIDWithName:self.filename extension:kJSQSystemSoundTypeAIF];
    XCTAssert(soundID, @"SoundID should not be nil");
 
    SystemSoundID nilSound = [self.sharedPlayer createSoundIDWithName:@"" extension:@""];
    XCTAssert(!nilSound, @"SoundID should be nil");
}

- (void)testRetrievingSoundIDsAndData
{
    SystemSoundID retrievedSoundID = [self.sharedPlayer soundIDForFilename:self.filename];
    XCTAssert(retrievedSoundID, @"SoundID should not be nil");
    
    NSData *soundData = [self.sharedPlayer dataWithSoundID:retrievedSoundID];
    XCTAssertNotNil(soundData, @"Sound data should not be nil");
    
    SystemSoundID soundIDFromData = [self.sharedPlayer soundIDFromData:soundData];
    XCTAssert(soundIDFromData, @"SoundID should not be nil");
    XCTAssertEqual(soundIDFromData, retrievedSoundID, @"SoundIDs should be equal");
}

- (void)testPlayingSounds
{
    XCTAssertNoThrow([self.sharedPlayer playSoundWithName:@"Basso"
                                                extension:kJSQSystemSoundTypeAIF
                                               completion:^{
                                                   NSLog(@"Completion block...");
                                               }],
                     @"Player should play sound and not throw");
    
    XCTAssertNoThrow([self.sharedPlayer playSoundWithName:@"Funk"
                                                extension:kJSQSystemSoundTypeAIFF],
                     @"Player should play sound and not throw");
    
    XCTAssertNoThrow([self.sharedPlayer playAlertSoundWithName:@"Basso"
                                                     extension:kJSQSystemSoundTypeAIF],
                     @"Player should play alert and not throw");
    
    XCTAssertNoThrow([self.sharedPlayer playAlertSoundWithName:@"Funk"
                                                     extension:kJSQSystemSoundTypeAIFF
                                                    completion:nil],
                     @"Player should play alert and not throw with nil block");
    
    XCTAssertNoThrow([self.sharedPlayer playAlertSoundWithName:nil
                                                     extension:nil],
                     @"Player should fail gracefully and not throw on nil params");
    
    XCTAssertNoThrow([self.sharedPlayer playAlertSoundWithName:@"BalladPiano"
                                                     extension:kJSQSystemSoundTypeAIFF],
                     @"Player should fail gracefully and not throw on incorrect extension");
    
    XCTAssertNoThrow([self.sharedPlayer playVibrateSound], @"Player should vibrate and not throw");
}

- (void)testSoundCompletionBlocks
{
    XCTAssertNoThrow([self.sharedPlayer playSoundWithName:@"Basso"
                                                extension:kJSQSystemSoundTypeAIF
                                               completion:^{
                                                   NSLog(@"Exectuing block...");
                                               }],
                     @"Player should play and now throw");
    
    XCTAssertTrue([self.sharedPlayer.completionBlocks count] == 1, @"Completion blocks dictionary should contain 1 object");
}

- (void)testMemoryWarning
{
    [self.sharedPlayer playSoundWithName:@"Basso"
                               extension:kJSQSystemSoundTypeAIF
                              completion:^{
                                  NSLog(@"Completion block...");
                              }];
    
    XCTAssertTrue([self.sharedPlayer.completionBlocks count] == 1, @"Completion blocks dictionary should contain 1 object");
    
    [self.sharedPlayer playAlertSoundWithName:@"Funk"
                                    extension:kJSQSystemSoundTypeAIFF];
    
    XCTAssertTrue([self.sharedPlayer.sounds count] == 2, @"Sounds dictionary should contain 2 objects");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UIApplicationDidReceiveMemoryWarningNotification
                                                        object:nil];
    
    XCTAssertTrue([self.sharedPlayer.sounds count] == 0, @"Sounds should have been purged on memory warning");
    XCTAssertTrue([self.sharedPlayer.completionBlocks count] == 0, @"Completion blocks should have been purged on memory warning");
}

@end
