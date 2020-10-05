# SkyWay iOS SDK release notes

[日本語](./release-notes.md)

## [Version 3.0.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.0.1)

### Fixed
- Fixed a problem in which the ICE Connection was disconnected without reconnecting when the ICE Connection was temporarily disconnected due to communication instability or other reasons.

## [Version 3.0.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.0.0)

### Breaking Changes

- The target OS has been changed to iOS 10.0 or higher.
- Updated internal libraries to improve stability.

## [Version 2.0.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v2.0.1)

### Fixed

- Addressed a vulnerability in SCTP.

## [Version 2.0.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v2.0.0)

### Breaking Changes

- Limited the interval between consecutive data sendings by using SFU/MeshRoom.send().
  - The frequency of consecutive data sending is limited to once every 100 msec.
  - The data that exceeds the limit is queued and sent sequentially every 100 msec.

## [Version 1.3.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.3.0)

### Added

- Added `getStats` function on `SKWMediaConnection`, `SKWDataConnection` for getting statistics of connection.

### Fixed

- Fixed a bug that error occurs when many users `Peer.joinRoom` at the same time in Mesh room.

### Modified
- Changed the max size of data to 20MB when calling `SKWMeshRoom.send` or `SKWSFURoom.send`.

## [Version 1.2.3](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.2.3)

### Fixed

- Fixed a bug that causes crash that occurred when emitting `SKW_ROOM_EVENT_PEER_JOIN` or `SKW_ROOM_EVENT_CLOSE` event.
- Fixed a bug that peerID could not be obtained in `SKW_ROOM_EVENT_PEER_JOIN` event.

## [Version 1.2.2](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.2.2)

### Fixed

- Fixed a bug that causes crash that occurred when `SKWNavigator.getUserMedia` calling in the simulator.

## [Version 1.2.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.2.1)

### Fixed

- Fixed a bug that causes crash of the app when calling `SKWMediaStream#close()`

## [Version 1.2.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.2.0)

### Added

- Added AutoLayout support for SKWVideo object.
- Added the following enums as `SKWVideoScalingEnum`.
  - `SKW_VIDEO_SCALING_ASPECT_FIT`
  - `SKW_VIDEO_SCALING_ASPECT_FILL`

### Fixed

- Fixed a bug that the front camera is selected in spite of the value of cameraPosition.

## [Version 1.1.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.1.1)

### Modified

- Added SKW_PEER_ERR_AUTHENTICATION to PeerError indicating API authentication error occurred.
- Added method `sdkVersion` for checking the SDK version to the SKWPeer class.

### Fixed
- Fixed a bug that API authentication fails in v1.1.0.

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
