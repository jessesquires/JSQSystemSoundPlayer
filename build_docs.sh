#!/bin/bash

# Docs by jazzy
# https://github.com/realm/jazzy
# ------------------------------

if which jazzy >/dev/null; then
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
        --output docs/
        exit
else
    echo "
    Error: jazzy not installed! <https://github.com/realm/jazzy>
    Install: gem install jazzy
    "
    exit 1
fi
