# SkyWay-iOS-Sample
Sample Application of SkyWay iOS SDK

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
open example_app.xcworkspace
```


### 3.Rewrite APIKEY, DOMAIN
please get APIKey and Domain from https://webrtc.ecl.ntt.com/

```
//Viewcontroller.m
static NSString *const kAPIkey = @"yourAPIKEY";
static NSString *const kDomain = @"yourDomain";

```
