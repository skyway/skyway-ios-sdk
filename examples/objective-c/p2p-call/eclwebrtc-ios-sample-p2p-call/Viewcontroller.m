//
//  ViewController.m
//  eclwebrtc-ios-sample-p2p-call
//
//  In this sample, a callee will be prompted by an alert-dialog to select
//  either "answer" or "reject" an incoming call (unlike p2p-videochat sample,
//  in which a callee will answer the call automatically).
//

#import "ViewController.h"

//
// Set your APIkey and Domain
//
static NSString *const kAPIkey = @"yourAPIKEY";
static NSString *const kDomain = @"yourDomain";
typedef NS_ENUM(NSInteger, CallState){
    CALL_STATE_TERMINATED,
    CALL_STATE_CALLING,
    CALL_STATE_ESTABLISHED
};

@interface ViewController () {
    SKWPeer*            _peer;
    SKWMediaStream*     _localStream;
    SKWMediaStream*     _remoteStream;
    SKWMediaConnection* _mediaConnection;
    SKWDataConnection*  _signalingChannel;
    
    NSString*           _strOwnId;
    BOOL                _bConnected;
    CallState          _callState;
    
    UIAlertController*  _alertController;
}

@property (weak, nonatomic) IBOutlet UILabel*   idLabel;
@property (weak, nonatomic) IBOutlet UIButton*  actionButton;
@property (weak, nonatomic) IBOutlet SKWVideo*  localView;
@property (weak, nonatomic) IBOutlet SKWVideo*  remoteView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _callState = CALL_STATE_TERMINATED;
    
    //
    // Initialize Peer
    //
    SKWPeerOption* option = [[SKWPeerOption alloc] init];
    option.key = kAPIkey;
    option.domain = kDomain;
    _peer	= [[SKWPeer alloc] initWithId:nil options:option];
    
    //
    // Set Peer event callbacks
    //
    
    // OPEN
    [_peer on:SKW_PEER_EVENT_OPEN callback:^(NSObject* obj) {
        
        // Show my ID
        self->_strOwnId = (NSString*) obj;
        self->_idLabel.text = self->_strOwnId;
        
        // Set MediaConstraints
        SKWMediaConstraints* constraints = [[SKWMediaConstraints alloc] init];
        constraints.maxWidth = 960;
        constraints.maxHeight = 540;
        constraints.cameraPosition = SKW_CAMERA_POSITION_FRONT;
        
        // Get a local MediaStream & show it
        [SKWNavigator initialize:self->_peer];
        self->_localStream = [SKWNavigator getUserMedia:constraints];
        [self->_localStream addVideoRenderer:self->_localView track:0];
        
    }];
    
    // CALL (Incoming call)
    [_peer on:SKW_PEER_EVENT_CALL callback:^(NSObject* obj) {
        if (YES == [obj isKindOfClass:[SKWMediaConnection class]]) {
            self->_mediaConnection = (SKWMediaConnection *)obj;
            self->_callState = CALL_STATE_CALLING;
            [self showIncomingCallAlert];
        }
    }];

    // CONNECT (Custom Signaling Channel for a call)
    [_peer on:SKW_PEER_EVENT_CONNECTION callback:^(NSObject* obj) {
        if (YES == [obj isKindOfClass:[SKWDataConnection class]]) {
            self->_signalingChannel = (SKWDataConnection *)obj;
            [self setSignalingCallbacks];
        }
    }];
    
    [_peer on:SKW_PEER_EVENT_CLOSE callback:^(NSObject* obj) {}];
    [_peer on:SKW_PEER_EVENT_DISCONNECTED callback:^(NSObject* obj) {}];
    [_peer on:SKW_PEER_EVENT_ERROR callback:^(NSObject* obj) {
        SKWPeerError* err = (SKWPeerError *)obj;
        NSLog(@"%@", err);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    [self updateActionButtonTitle];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    _localStream = nil;
    _remoteStream = nil;
    _strOwnId = nil;
    _mediaConnection = nil;
    _peer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//
// Set callbacks for MEDIACONNECTION_EVENTs
//
- (void)setMediaCallbacks {
    if (nil == _mediaConnection) {
        return;
    }

    [_mediaConnection on:SKW_MEDIACONNECTION_EVENT_STREAM callback:^(NSObject* obj) {
         if (YES == [obj isKindOfClass:[SKWMediaStream class]]) {
             if (CALL_STATE_ESTABLISHED == self->_callState) {
                 return;
             }
             
             // Change connection state
             self->_callState = CALL_STATE_ESTABLISHED;
             [self updateActionButtonTitle];
             
             // Get a remote MediaStream & show it
             self->_remoteStream = (SKWMediaStream *)obj;
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self->_remoteStream addVideoRenderer:self->_remoteView track:0];
             });
             
         }
     }];
    
    [_mediaConnection on:SKW_MEDIACONNECTION_EVENT_CLOSE callback:^(NSObject* obj) {
        if (CALL_STATE_ESTABLISHED != self->_callState) {
            return;
        }

        [self closeRemoteStream];
        [self unsetMediaCallbacks];
        self->_mediaConnection = nil;
        [self->_signalingChannel close:YES];
        self->_callState = CALL_STATE_TERMINATED;
        [self updateActionButtonTitle];

     }];
    
    [_mediaConnection on:SKW_MEDIACONNECTION_EVENT_ERROR callback:^(NSObject* obj) {
        SKWPeerError* err = (SKWPeerError *)obj;
        NSLog(@"%@", err);
    }];
}

//
// Set callbacks for SKW_DATACONNECTION_EVENTs
//
- (void)setSignalingCallbacks {
    if (nil == _signalingChannel) {
        return;
    }
    
    [_signalingChannel on:SKW_DATACONNECTION_EVENT_OPEN callback:^(NSObject* obj) { }];
    [_signalingChannel on:SKW_DATACONNECTION_EVENT_CLOSE callback:^(NSObject* obj) { }];
    [_signalingChannel on:SKW_DATACONNECTION_EVENT_ERROR callback:^(NSObject* obj) {
        SKWPeerError* err = (SKWPeerError *)obj;
        NSLog(@"%@", err);
    }];
    [_signalingChannel on:SKW_DATACONNECTION_EVENT_DATA callback:^(NSObject* obj) {
        NSString *message = (NSString *)obj;
        NSLog(@"[On/Data] %@", message);
        
        if ([message isEqualToString:@"reject"]) {
            [self->_mediaConnection close:YES];
            [self->_signalingChannel close:YES];
            self->_callState = CALL_STATE_TERMINATED;
            [self updateActionButtonTitle];
        }
        else if ([message isEqualToString:@"cancel"]) {
            [self->_mediaConnection close:YES];
            [self->_signalingChannel close:YES];
            self->_callState = CALL_STATE_TERMINATED;
            [self updateActionButtonTitle];
            [self dismissIncomingCallAlert];
        }
    }];
}

//
// Unset callbacks for PEER_EVENTs
//
- (void)unsetPeerCallbacks {
    if (nil == _peer) {
        return;
    }
    
    [_peer on:SKW_PEER_EVENT_OPEN callback:nil];
    [_peer on:SKW_PEER_EVENT_CONNECTION callback:nil];
    [_peer on:SKW_PEER_EVENT_CALL callback:nil];
    [_peer on:SKW_PEER_EVENT_CLOSE callback:nil];
    [_peer on:SKW_PEER_EVENT_DISCONNECTED callback:nil];
    [_peer on:SKW_PEER_EVENT_ERROR callback:nil];
}

//
// Unset callbacks for MEDIACONNECTION_EVENTs
//
- (void)unsetMediaCallbacks {
    if(nil == _mediaConnection) {
        return;
    }
    
    [_mediaConnection on:SKW_MEDIACONNECTION_EVENT_STREAM callback:nil];
    [_mediaConnection on:SKW_MEDIACONNECTION_EVENT_CLOSE callback:nil];
    [_mediaConnection on:SKW_MEDIACONNECTION_EVENT_ERROR callback:nil];
}

//
// Close & release a remote MediaStream
//
- (void) closeRemoteStream {
    if(nil == _remoteStream) {
        return;
    }
    
    if(nil != _remoteView) {
        [_remoteStream removeVideoRenderer:_remoteView track:0];
    }
    
    [_remoteStream close];
    _remoteStream = nil;
}

//
// Create a MediaConnection
//
- (void) didSelectPeer:(NSString *)peerId {
    _mediaConnection = [_peer callWithId:peerId stream:_localStream];
    [self setMediaCallbacks];
    _callState = CALL_STATE_CALLING;
    
    // custom P2P signaling channel to reject call attempt
    _signalingChannel = [_peer connectWithId:peerId];
    [self setSignalingCallbacks];
}

//
// Action for actionButton (make/hang up a call)
//
- (IBAction)onActionButtonClicked:(id)sender {
    
//    if(nil == _mediaConnection) {
    if(CALL_STATE_TERMINATED == _callState) {
        
        //
        // Select remote peer & make a call
        //
        
        // Get all IDs connected to the server
        [_peer listAllPeers:^(NSArray* aryPeers){
            NSMutableArray* maItems = [[NSMutableArray alloc] init];
            if (nil == self->_strOwnId) {
                 return;
            }
            
            // Exclude my own ID
            for (NSString* strValue in aryPeers) {
                if (NSOrderedSame != [self->_strOwnId caseInsensitiveCompare:strValue]) {
                    [maItems addObject:strValue];
                }
            }
            
            // Show IDs using UITableViewController
            PeerListViewController* vc = [[PeerListViewController alloc] initWithStyle:UITableViewStylePlain];
            vc.items = [NSArray arrayWithArray:maItems];
            vc.delegate = self;
            
            UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:vc];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:nc animated:YES completion:nil];
            });
            
            [maItems removeAllObjects];
        
        }];
    }
    else if(CALL_STATE_CALLING == _callState){
        
        //
        // Cancel a call
        //
        
        if(nil != _signalingChannel){
            [_signalingChannel send:@"cancel"];
        }
        _callState = CALL_STATE_TERMINATED;
        [self updateActionButtonTitle];
        
    }
    else {
        
        //
        // hang up a call
        //
        
        [self closeRemoteStream];
        [_mediaConnection close:YES];
        [_signalingChannel close:YES];
        _callState = CALL_STATE_TERMINATED;
        [self updateActionButtonTitle];
        
    }
}

//
// Update actionButton title
//
- (void)updateActionButtonTitle {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* title;
        if(CALL_STATE_TERMINATED == self->_callState){
            title = @"Make Call";
        }
        else if(CALL_STATE_CALLING == self->_callState){
            title = @"Cancel";
        }
        else {
            title = @"Hang up";
        }
        [self->_actionButton setTitle:title forState:UIControlStateNormal];
    });
}

//
// Action for switchCameraButton
//
- (IBAction)onSwitchCameraButtonClicked:(id)sender {
    if(nil == _localStream) {
        return;
    }
    
    SKWCameraPositionEnum pos = [_localStream getCameraPosition];
    if(SKW_CAMERA_POSITION_BACK == pos) {
        pos = SKW_CAMERA_POSITION_FRONT;
    }
    else if(SKW_CAMERA_POSITION_FRONT == pos) {
        pos = SKW_CAMERA_POSITION_BACK;
    }
    else {
        return;
    }
    
    [_localStream setCameraPosition:pos];
}

//
// Show alert dialog on an incoming call
//
- (void)showIncomingCallAlert {
    NSString *remotePeerId = [NSString stringWithFormat:@"from : %@", _mediaConnection.peer];
    _alertController = [UIAlertController
                       alertControllerWithTitle:@"Incoming Call"
                       message:remotePeerId
                       preferredStyle:UIAlertControllerStyleAlert];

    [_alertController addAction:[UIAlertAction
                                actionWithTitle:@"Answer"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action) {
                                    [self setMediaCallbacks];
                                    [self->_mediaConnection answer:self->_localStream];
                                }]];

    [_alertController addAction:[UIAlertAction
                                actionWithTitle:@"Reject"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action) {
                                    [self->_signalingChannel send:@"reject"];
                                    self->_callState = CALL_STATE_TERMINATED;
                                }]];

    [self presentViewController:_alertController animated:YES completion:nil];
}

//
// Dismiss alert dialog for an incoming call
//
- (void)dismissIncomingCallAlert {
    [_alertController dismissViewControllerAnimated:YES completion:nil];
}

@end
