# SkyWay iOS SDK release notes

[日本語](./release-notes.md)

## [Version 1.1.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.1.0)

### Modified
- The SDK now supports a minimum OS version of iOS 9.

### Fixed

- Fixed bug that causes unintended re-connecting when disconnecting with.

## [Version 1.0.6](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.6)

### Fixed

- Fixed bug that rarely causes crash of the app when failed to connect the server by the other factor of v1.0.5.

## [Version 1.0.5](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.5)

### Fixed

- Fixed bug that rarely causes crash of the app when connection to server fails.
- Fixed bug that it cannot get correct number of audio track in getAudioTrack.

## [Version 1.0.4](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.4)

### Fixed

- Fixed bug that causes crash of the app when call destroy after calling disconnect.
- Fixed bug in switchCamera method.

## [Version 1.0.3](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.3)

### Added

- Enabled Bitcode.
- Added support for rendering the same SKWVideo in multiple views.

### Fixed

- Fixed bug in reconnect method.
- Fixed bug in listAllPeers method when the API fails.
- Fixed possible memory leak in DataConnection.
- Fixed bug that causes crash of the app when connecting DataConnection.
- Fixed bug that re-joining to the same room after leaving it may fail.
- Fixed bug that SKW_ROOM_EVENT_REMOVE_STREAM was not fired in SFURoom.

## [Version 1.0.2](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.2)

### Fixed

- Fixed bug in an IPv6 environment.

## [Version 1.0.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.1)

### Fixed

- Fixed bug that metadata on Media/DataConnection class was not set.

## [Version 1.0.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.0)

- first release
