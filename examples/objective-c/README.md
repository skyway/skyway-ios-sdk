# Objective-C SkyWay-iOS-Sample
sample Application of SkyWay iOS SDK

## Build & run sample application

### 1.Installation
SkyWay iOS SDK is added as a dependency using [CocoaPods](https://cocoapods.org/). Setup the workspace using:

```
cd example_app
pod install
```
### 2.Open xcworkspace file
Make sure to always open the Xcode workspace instead of the project file when building your project:
```
open example_app.xcworkspace
```


### 3.Rewrite APIKEY, DOMAIN
please get APIKey and Domain from https://webrtc.ecl.ntt.com/

```
//Viewcontroller.m
static NSString *const kAPIkey = @"yourAPIKEY";
static NSString *const kDomain = @"yourDomain";

```

---
# Objective-C SkyWay-iOS-Sample
SkyWay-iOS-SDKのObjective-C版のサンプルアプリケーションです。

## Build & run sample application

### 1.インストール
SkyWay iOS SDKは、[CocoaPods](https://cocoapods.org/)を使用して依存関係を追加しています。以下のコマンドでワークスペースを設定します。
```
cd example_app
pod install
```
### 2.xcworkspaceファイルを開く
プロジェクトをビルドするときは、必ずプロジェクトファイルではなくXcodeワークスペースを開いてください。
```
open example_app.xcworkspace
```


### 3.APIキーとドメインを書き換える
https://webrtc.ecl.ntt.com/ からAPIキーとドメインを取得してください。

```
//Viewcontroller.m
static NSString *const kAPIkey = @"yourAPIKEY";
static NSString *const kDomain = @"yourDomain";

```
