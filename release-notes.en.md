# SkyWay iOS SDK release notes

[日本語](./release-notes.md)

## [Version 4.0.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v4.0.0) - 2021-05-27

### Breaking Changed

- Updated internal WebRTC libraries to improve stability.
  - This version fails to negotiate and communicate with Chrome 71 or earlier, Android SDK v1.0.6 or earlier, iOS SDK v1.0.6 or earlier, and WebRTC Gateway v0.1.0 or earlier.
 ([Ref](https://support.skyway.io/hc/articles/900005631283))

### Fixed

- Fixed a bug that various operations did not work properly when the `Peer` automatically reconnected to a signaling server.
- Fixed a bug that after updating a credential used for Peer authentication, caused a `Peer` uses old credential when it automatically reconnected to a signaling server.
- Enhanced security.

## [Version 3.6.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.6.0) - 2021-02-16

### Deprecated

- Deprecated `reconnect` method of `SKWPeer`. Recreate `SKWPeer` instance instead.
- Deprecated `disconnect` method of `SKWPeer`. Use `disconnect` method of `SKWPeer` instead.
- Deprecated `DISCONNECTED` event of `SKWPeerEventEnum`. Use `CLOSE` event of `SKWPeerEventEnum` instead.
- Deprecated `REMOVE_STREAM` event of `SKWRoomEventEnum`. Use `PEER_LEAVE` evnet of `SKWRoomEventEnum` instead.

## [Version 3.5.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.5.0) - 2021-02-02

### Changed

- Changed `dataChannel.send()` interval so that multiple data can be transmitted without delay even when those data are continuously transmitted at an intervals of less than 100 msec.

## [Version 3.4.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.4.0) - 2021-01-19

### Fixed

- Fixed a connecting process to signaling server so that `Peer` would reconnect when a request to the dispatcher server failed.

## [Version 3.3.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.3.0) - 2020-12-22
### Added

- Added `fetchPeerExistsWithPeerId` API to fetch whether a peer exists. You can call this API once per second per peer.

### Fixed

- Fixed a bug that the PeerID would change when a Peer created without specifying PeerID automatically reconnected to SkyWay's signaling server due to reasons such as network disconnection of the mobile device.
- Fixed a bug that after updating a credential used for API key authentication (Peer authentication), caused a Peer to fail to reconnect to SkyWay's signaling server when it automatically reconnected.
- Fixed a bug that caused the open event of Peer to fire again when the Peer automatically reconnected to SkyWay's signaling server.

## [Version 3.2.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.2.0) - 2020-11-16

### Added

- Added `tryReconnectMedia` and `tryReconnectData` option to `PeerOption`. This enables to try to reconnect automatically when the WebRTC communication state is temporarily disconnected due to unstable communication or other reasons. The default value is false.

## [Version 3.1.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.1.0) - 2020-11-02

### Added

- Add an `forceClose` option when calling `SKWMediaConnection`, `SKWDataConnection` to signal intention to disconnection to the remote peer instantly.

### Deprecated

- The `NO` default value of `forceClose` is deprecated and may be changed to `YES` in future versions.

## [Version 3.0.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.0.1) - 2020-10-05

### Fixed

- Fixed to automatically try to reconnect when WebRTC communication state is temporarily disconnected due to unstable communication or other reasons.

## [Version 3.0.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.0.0) - 2020-08-31

### Breaking Changes

- The target OS has been changed to iOS 10.0 or higher.
- Updated internal libraries to improve stability.

## [Version 2.0.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v2.0.1) - 2020-06-30

### Fixed

- Addressed a vulnerability in SCTP.

## [Version 2.0.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v2.0.0) - 2020-06-09

### Breaking Changes

- Limited the interval between consecutive data sendings by using SFU/MeshRoom.send().
  - The frequency of consecutive data sending is limited to once every 100 msec.
  - The data that exceeds the limit is queued and sent sequentially every 100 msec.

## [Version 1.3.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.3.0) - 2020-04-28

### Added

- Added `getStats` function on `SKWMediaConnection`, `SKWDataConnection` for getting statistics of connection.

### Fixed

- Fixed a bug that error occurs when many users `Peer.joinRoom` at the same time in Mesh room.

### Modified
- Changed the max size of data to 20MB when calling `SKWMeshRoom.send` or `SKWSFURoom.send`.

## [Version 1.2.3](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.2.3) - 2020-01-30

### Fixed

- Fixed a bug that causes crash that occurred when emitting `SKW_ROOM_EVENT_PEER_JOIN` or `SKW_ROOM_EVENT_CLOSE` event.
- Fixed a bug that peerID could not be obtained in `SKW_ROOM_EVENT_PEER_JOIN` event.

## [Version 1.2.2](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.2.2) - 2019-12-18

### Fixed

- Fixed a bug that causes crash that occurred when `SKWNavigator.getUserMedia` calling in the simulator.

## [Version 1.2.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.2.1) - 2019-10-24

### Fixed

- Fixed a bug that causes crash of the app when calling `SKWMediaStream#close()`

## [Version 1.2.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.2.0) - 2019-05-20

### Added

- Added AutoLayout support for SKWVideo object.
- Added the following enums as `SKWVideoScalingEnum`.
  - `SKW_VIDEO_SCALING_ASPECT_FIT`
  - `SKW_VIDEO_SCALING_ASPECT_FILL`

### Fixed

- Fixed a bug that the front camera is selected in spite of the value of cameraPosition.

## [Version 1.1.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.1.1) - 2019-04-09

### Modified

- Added SKW_PEER_ERR_AUTHENTICATION to PeerError indicating API authentication error occurred.
- Added method `sdkVersion` for checking the SDK version to the SKWPeer class.

### Fixed
- Fixed a bug that API authentication fails in v1.1.0.

## [Version 1.1.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.1.0) - 2019-03-18

### Modified

- The SDK now supports a minimum OS version of iOS 9.

### Fixed

- Fixed bug that causes unintended re-connecting when disconnecting with.

## [Version 1.0.6](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.6) - 2018-09-04

### Fixed

- Fixed bug that rarely causes crash of the app when failed to connect the server by the other factor of v1.0.5.

## [Version 1.0.5](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.5) - 2018-08-09

### Fixed

- Fixed bug that rarely causes crash of the app when connection to server fails.
- Fixed bug that it cannot get correct number of audio track in getAudioTrack.

## [Version 1.0.4](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.4) - 2018-04-10

### Fixed

- Fixed bug that causes crash of the app when call destroy after calling disconnect.
- Fixed bug in switchCamera method.

## [Version 1.0.3](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.3) - 2018-03-16

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

## [Version 1.0.2](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.2) - 2017-10-20

### Fixed

- Fixed bug in an IPv6 environment.

## [Version 1.0.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.1) - 2017-09-15

### Fixed

- Fixed bug that metadata on Media/DataConnection class was not set.

## [Version 1.0.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.0) - 2017-09-06

- first release
