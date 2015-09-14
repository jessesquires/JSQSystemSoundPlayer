#!/bin/bash

xctool \
   -project Example/Example.xcodeproj \
   -scheme Example-iOS \
   -sdk iphonesimulator \
   ONLY_ACTIVE_ARCH=NO \
   clean build

xctool \
   -project Example/Example.xcodeproj \
   -scheme Example-OSX \
   ONLY_ACTIVE_ARCH=NO \
   clean build

xctool \
   -project JSQSystemSoundPlayer/JSQSystemSoundPlayer.xcodeproj \
   -scheme JSQSystemSoundPlayer-OSX \
   -sdk iphonesimulator \
   ONLY_ACTIVE_ARCH=NO \
   clean build

xcodebuild \
   -project JSQSystemSoundPlayer/JSQSystemSoundPlayer.xcodeproj \
   -scheme JSQSystemSoundPlayer-iOS \
   -sdk iphonesimulator \
   ONLY_ACTIVE_ARCH=NO \
   GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES \
   GCC_GENERATE_TEST_COVERAGE_FILES=YES \
   clean build test
