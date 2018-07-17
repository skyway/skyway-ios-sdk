//
//  RoomCollectionViewController.h
//  eclwebrtc-ios-sample-mesh-videochat
//
//

#import <UIKit/UIKit.h>
#import "SkyWay/SkyWay.h"

@interface RoomCollectionViewController : UICollectionViewController

- (void)addMediaStream:(SKWMediaStream*)stream;

- (void)removeMediaStream:(SKWMediaStream*)stream;

- (void)removeAllMediaStreams;

- (void)removePeerStreams:(NSString*)peerId;

@end
