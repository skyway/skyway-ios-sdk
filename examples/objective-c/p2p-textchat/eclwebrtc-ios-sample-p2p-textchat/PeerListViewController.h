//
// PeerListViewController.h
// eclwebrtc-ios-sample-p2p-videochat
//

#import <UIKit/UIKit.h>

@protocol PeerListDelegate <NSObject>

- (void) didSelectPeer:(NSString*)peerId;

@end

@interface PeerListViewController : UITableViewController

@property (nonatomic, nonnull) UITableView* tableView;
@property (strong, nonatomic) NSArray* items;
@property (nonatomic, weak) id<PeerListDelegate> delegate;

@end
