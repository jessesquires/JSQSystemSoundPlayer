#!/bin/bash

# Docs by jazzy
# https://github.com/realm/jazzy
# ------------------------------

jazzy \
    --clean \
    --author 'Jesse Squires' \
    --author_url 'https://twitter.com/jesse_squires' \
    --github_url 'https://github.com/jessesquires/JSQSystemSoundPlayer' \
    --module 'JSQSystemSoundPlayer' \
    --umbrella-header 'Source/JSQSystemSoundPlayer.h' \
    --framework-root . \
    --objc \
    --readme 'README.md' \
    --documentation 'Guides/*.md' \
    --output docs/ \
