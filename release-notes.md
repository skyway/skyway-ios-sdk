# SkyWay iOS SDK release notes

[English](./release-notes.en.md)

## [Version 1.2.3](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.2.3)

### Fixed

- `SKW_ROOM_EVENT_PEER_JOIN` または`SKW_ROOM_EVENT_CLOSE` イベントの発火時にクラッシュする不具合を修正しました
- `SKW_ROOM_EVENT_PEER_JOIN`イベントでpeerIDが取得できない不具合を修正しました

## [Version 1.2.2](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.2.2)

### Fixed

- シミュレーターで`SKWNavigator.getUserMedia`を呼び出した時にクラッシュする不具合を修正しました。

## [Version 1.2.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.2.1)

### Fixed

- SKWMediaStreamをcloseした時にクラッシュする不具合を修正しました。

## [Version 1.2.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.2.0)

### Added

- SKWVideoがAutoLayoutに対応しました。
- `SKWVideoScalingEnum`として以下の列挙子を追加しました。
  - `SKW_VIDEO_SCALING_ASPECT_FIT`
  - `SKW_VIDEO_SCALING_ASPECT_FILL`

### Fixed

- cameraPositionの値に関わらずフロントカメラが選択される不具合を修正しました。

## [Version 1.1.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.1.1)

### Modified

- API認証エラー発生を示すSKW_PEER_ERR_AUTHENTICATIONをPeerErrorに追加しました。
- SKWPeerクラスにSDKのバージョン確認用のメソッド`(nonnull NSString*)sdkVersion`を追加しました。

### Fixed

- v1.1.0にてAPI認証に失敗する不具合を修正しました。

## [Version 1.1.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.1.0)

### Modified

- 対象OSを iOS 9.0以上に変更しました。

### Fixed

- サーバとの切断時に意図しない再接続が発生する不具合を解消しました。

## [Version 1.0.6](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.6)

### Fixed

- v.1.0.5とは別の要因により、サーバへの接続失敗時に稀にクラッシュする不具合を解消しました。

## [Version 1.0.5](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.5)

### Fixed

- サーバへの接続失敗時に稀にクラッシュする不具合を解消しました。
- getAudioTrack実行時に正常にTrack数が取得出来ない不具合を解消しました。

## [Version 1.0.4](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.4)

### Fixed

- disconnectメソッド後にdestroyメソッドを呼ぶとクラッシュする不具合を解消しました。
- switchCameraメソッドが動作しない不具合を解消しました。

## [Version 1.0.3](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.3)

### Added

- bitcode を有効化しました。
- 1つのstreamを同時に複数のSKWVideo viewにレンダリングできるよう対応しました。

### Fixed

- reconnectメソッドが正しく動作しない不具合を解消しました。
- listAllPeersメソッドのAPIエラー時の不具合を解消しました。
- DataConnectionのメモリリークを解消しました。
- DataConnectionの確立時にクラッシュする事がある不具合を解消しました。
- MeshRoomから退室後、再入室できない事がある不具合を解消しました。
- SFURoomで`SKW_ROOM_EVENT_REMOVE_STREAM` が発火しない不具合を解消しました。

## [Version 1.0.2](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.2)

### Fixed

- IPv6環境下での動作不具合を解消しました。

## [Version 1.0.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.1)

### Fixed

- Media/DataConnectionクラスのmetadataオプションが設定されない不具合を解消しました。

## [Version 1.0.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.0)

- first release
