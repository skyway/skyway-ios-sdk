# SkyWay iOS SDK release notes

[English](./release-notes.en.md)

## [Version 4.0.2](https://github.com/skyway/skyway-ios-sdk/releases/tag/v4.0.2) - 2022-05-10

### Fixed

- サーバへのリクエストにおいて、リクエストヘッダにSNIの情報が付与されない不具合を修正しました。

## [Version 4.0.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v4.0.1) - 2022-03-16

### Fixed

- レイアウトを変更すると `SKWVideo` 内の `RTCEAGLVideoView` のフレームサイズが正しくならない場合がある不具合を修正しました。

## [Version 4.0.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v4.0.0) - 2021-05-27
### Breaking Changed

- 内部で利用しているWebRTCライブラリを更新し、動作の安定性を向上させました。
  - Chrome71以前、iOS/Android SDK 1.0.6以前、WebRTC Gateway v0.1.0以前との疎通ができなくなります。 ([参考](https://support.skyway.io/hc/articles/900005631283))

### Fixed

- `Peer` がシグナリングサーバと自動再接続した際に、各種操作が正常に動作しない不具合を修正しました。
- Peer認証に利用されるCredentialの更新後に `Peer` がシグナリングサーバと自動再接続する際に、更新前の `Credential` を利用してしまう不具合を修正しました。
- セキュリティの強化を実施しました。

## [Version 3.6.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.6.0) - 2021-02-16

### Deprecated
- `SKWPeer`の`reconnect`メソッドを非推奨にしました。代わりに`SKWPeer`の再作成を推奨します。
- `SKWPeer`の`disconnect`メソッドを非推奨にしました。代わりに`SKWPeer`の`destroy`メソッドの使用を推奨します。
- `SKWPeerEventEnum`の`DISCONNECTED`イベントを非推奨にしました。代わりに`SKWPeerEventEnum`の`CLOSE`イベントの使用を推奨します。
- `SKWRoomEventEnum`の`REMOVE_STREAM`イベントを非推奨にしました。代わりに`SKWRoomEventEnum`の`PEER_LEAVE`イベントの使用を推奨します。

## [Version 3.5.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.5.0) - 2021-02-02

### Changed
- `dataChannel.send`の送信間隔を変更し、100msec未満の間隔で連続送信する際も遅延なくデータの送信を行うことができるようになりました。

## [Version 3.4.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.4.0) - 2021-01-19

### Fixed

- シグナリングサーバへの接続プロセスを修正し、`Peer` からディスパッチャーサーバへのリクエストが失敗した場合に再接続するようにしました。

## [Version 3.3.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.3.0) - 2020-12-22
### Added

- Peerの存在を確認することができる `fetchPeerExistsWithPeerId` メソッドを追加しました。1秒に1回利用することが可能です。

### Fixed

- PeerIDを指定せずに生成したPeerが、モバイル端末のネットワーク切断等でシグナリングサーバと自動再接続する際に、PeerIDが変わってしまう不具合を修正しました。
- APIキー認証 (Peer認証) に使用されるCredentialの更新後にPeerがシグナリングサーバと自動再接続する際、再接続に失敗する不具合を修正しました。
- Peerがシグナリングサーバと自動再接続する際に、Peerのopenイベントが再発火する不具合を修正しました。

## [Version 3.2.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.2.0) - 2020-11-16
### Added

- Peer オプションに `tryReconnectMedia` と `tryReconnectData` のオプションを追加しました。このオプションを有効にすることで、WebRTC通信が一時的な切断状態になった場合に自動再接続を試行するようになります。デフォルトではこのオプションは無効です。

## [Version 3.1.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.1.0) - 2020-11-02
### Added

- `SKWMediaConnection`, `SKWDataConnection` に `forceClose` オプションを追加しました。このオプションを有効にすると、接続相手においても各 `Connection` が即座にクローズします。

### Deprecated

- `forceClose` のデフォルト値 `NO` は将来のバージョンでは `YES` に変更される可能性があります。

## [Version 3.0.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.0.1) - 2020-10-05

### Fixed

- 通信状態が不安定等の理由により、WebRTC通信が一時的な切断状態になった場合に、自動で再接続を試行するように修正しました。

## [Version 3.0.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v3.0.0) - 2020-08-31

### Breaking Changes

- 対象OSを iOS 10.0以上に変更しました。
- 内部ライブラリのアップデートを行い、安定性を向上させました。

## [Version 2.0.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v2.0.1) - 2020-06-30

### Fixed

- SCTPに関する脆弱性への対応を行いました。

## [Version 2.0.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v2.0.0) - 2020-06-09

### Breaking Changes

- `MeshRoom`, `SFURoom`の`send`関数を使用してデータを送信する際、その送信間隔に制限を設けました。
  - 連続してデータを送信する頻度は 100 ミリ秒に 1 回までに制限されます。
  - 制限を超えたデータはキューイングされ、100 ミリ秒ごとに順次送信されます。

## [Version 1.3.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.3.0) - 2020-04-28

### Added

- `SKWMediaConnection`, `SKWDataConnection`に接続中の統計情報を取得する`getStats`関数を追加しました。

### Fixed

- 同じ`MeshRoom`に対して多数のユーザが同時に`Peer.joinRoom`した際に、エラーが発生する不具合を修正しました。

### Modified

- `SKWMeshRoom`, `SKWSFURoom`の`send`関数において、送信可能なデータのサイズ上限を20MBに変更しました。

## [Version 1.2.3](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.2.3) - 2020-01-30

### Fixed

- `SKW_ROOM_EVENT_PEER_JOIN` または`SKW_ROOM_EVENT_CLOSE` イベントの発火時にクラッシュする不具合を修正しました。
- `SKW_ROOM_EVENT_PEER_JOIN`イベントでpeerIDが取得できない不具合を修正しました。

## [Version 1.2.2](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.2.2) - 2019-12-18

### Fixed

- シミュレーターで`SKWNavigator.getUserMedia`を呼び出した時にクラッシュする不具合を修正しました。

## [Version 1.2.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.2.1) - 2019-10-24

### Fixed

- SKWMediaStreamをcloseした時にクラッシュする不具合を修正しました。

## [Version 1.2.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.2.0) - 2019-05-20

### Added

- SKWVideoがAutoLayoutに対応しました。
- `SKWVideoScalingEnum`として以下の列挙子を追加しました。
  - `SKW_VIDEO_SCALING_ASPECT_FIT`
  - `SKW_VIDEO_SCALING_ASPECT_FILL`

### Fixed

- cameraPositionの値に関わらずフロントカメラが選択される不具合を修正しました。

## [Version 1.1.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.1.1) - 2019-04-09

### Modified

- API認証エラー発生を示すSKW_PEER_ERR_AUTHENTICATIONをPeerErrorに追加しました。
- SKWPeerクラスにSDKのバージョン確認用のメソッド`(nonnull NSString*)sdkVersion`を追加しました。

### Fixed

- v1.1.0にてAPI認証に失敗する不具合を修正しました。

## [Version 1.1.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.1.0) - 2019-03-18

### Modified

- 対象OSを iOS 9.0以上に変更しました。

### Fixed

- サーバとの切断時に意図しない再接続が発生する不具合を解消しました。

## [Version 1.0.6](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.6) - 2018-09-04

### Fixed

- v.1.0.5とは別の要因により、サーバへの接続失敗時に稀にクラッシュする不具合を解消しました。

## [Version 1.0.5](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.5) - 2018-08-09

### Fixed

- サーバへの接続失敗時に稀にクラッシュする不具合を解消しました。
- getAudioTrack実行時に正常にTrack数が取得出来ない不具合を解消しました。

## [Version 1.0.4](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.4) - 2018-04-10

### Fixed

- disconnectメソッド後にdestroyメソッドを呼ぶとクラッシュする不具合を解消しました。
- switchCameraメソッドが動作しない不具合を解消しました。

## [Version 1.0.3](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.3) - 2018-03-16

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

## [Version 1.0.2](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.2) - 2017-10-20

### Fixed

- IPv6環境下での動作不具合を解消しました。

## [Version 1.0.1](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.1) - 2017-09-15

### Fixed

- Media/DataConnectionクラスのmetadataオプションが設定されない不具合を解消しました。

## [Version 1.0.0](https://github.com/skyway/skyway-ios-sdk/releases/tag/v1.0.0) - 2017-09-06

- first release
