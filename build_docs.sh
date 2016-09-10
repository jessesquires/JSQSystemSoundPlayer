#!/bin/bash

# Docs by jazzy
# https://github.com/realm/jazzy
# ------------------------------

jazzy --objc \
      --module 'JSQSystemSoundPlayer' \
      --framework-root JSQSystemSoundPlayer/ \
      --umbrella-header Source/JSQSystemSoundPlayer.h \
      --readme README.md \
      --author 'Jesse Squires' \
      --author_url 'https://twitter.com/jesse_squires' \
      --github_url 'https://github.com/jessesquires/JSQSystemSoundPlayer' \
      --output docs/ \
