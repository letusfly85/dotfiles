#/usr/bin/env bash

## fvm
brew tap leoafarias/fvm
brew install fvm

## Dart
brew tap dart-lang/dart
brew install dart
dart pub global activate fvm

## XCode
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
sudo gem install activesupport -v 6.1.7.3
sudo gem install cocoapods

## Check
fvm flutter --version
fvm flutter doctor
fvm flutter run
