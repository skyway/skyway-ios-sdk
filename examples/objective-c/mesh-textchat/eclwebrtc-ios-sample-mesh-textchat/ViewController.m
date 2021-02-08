//
//  ViewController.m
//  eclwebrtc-ios-sample-mesh-videochat
//
//

#import "ViewController.h"

//
// Set your APIkey and Domain
//
static NSString *const kAPIkey = @"yourAPIKEY";
static NSString *const kDomain = @"yourDomain";

@interface ViewController () {
    SKWPeer*                        _peer;
    SKWMeshRoom*                    _meshRoom;
    NSString*                       _strOwnId;
    
    TextChatTableViewController*    _tableViewController;
}

@property(nonatomic) IBOutlet UILabel*      idLabel;
@property(nonatomic) IBOutlet UITextField*  roomNameField;
@property(nonatomic) IBOutlet UITextField*  messageField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _idLabel.text = @"N/A";
    _roomNameField.delegate = self;
    _messageField.delegate = self;
    
    //
    // Initialize Peer
    //
    SKWPeerOption* options = [[SKWPeerOption alloc] init];
    options.key = kAPIkey;
    options.domain = kDomain;
    _peer = [[SKWPeer alloc] initWithOptions:options];
    
    //
    // Set Peer event callbacks
    //
    
    // OPEN
    [_peer on:SKW_PEER_EVENT_OPEN callback:^(NSObject* obj) {
        // Show my ID
        self->_strOwnId = (NSString*)obj;
        self->_idLabel.text = self->_strOwnId;
    }];
    
    // CLOSE
    [_peer on:SKW_PEER_EVENT_CLOSE callback:^(NSObject* obj) {
        self->_idLabel.text = @"N/A";
        [SKWNavigator terminate];
        self->_peer = nil;
    }];
    
    [_peer on:SKW_PEER_EVENT_ERROR callback:^(NSObject* obj) {}];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    _strOwnId = nil;
    _meshRoom = nil;
    _peer = nil;
    _tableViewController = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//
// Action for joinButton
//
- (IBAction)onJoinButtonClicked:(id)sender {
    if (nil == _peer || nil != _meshRoom || 0 == _roomNameField.text.length){
        return;
    }
    
    //
    // Join to a MeshRoom
    //
    SKWRoomOption* option = [[SKWRoomOption alloc] init];
    option.mode = SKW_ROOM_MODE_MESH;
    NSString* roomName = [NSString stringWithFormat:@"%@", _roomNameField.text];
    _meshRoom = (SKWMeshRoom*)[_peer joinRoomWithName:roomName options:option];
    
    //
    // Set callbacks for ROOM_EVENTs
    //
    [_meshRoom on:SKW_ROOM_EVENT_OPEN callback:^(NSObject* arg) {
        NSString* roomName = (NSString*)arg;
        NSLog(@"SKW_ROOM_EVENT_OPEN: %@", roomName);
    }];
    [_meshRoom on:SKW_ROOM_EVENT_CLOSE callback:^(NSObject* arg) {
        NSString* roomName = (NSString*)arg;
        NSLog(@"SKW_ROOM_EVENT_CLOSE: %@", roomName);
        [self->_meshRoom offAll];
        self->_meshRoom = nil;
    }];
    [_meshRoom on:SKW_ROOM_EVENT_PEER_JOIN callback:^(NSObject* arg) {
        NSString* peerId_ = (NSString*)arg;
        NSLog(@"SKW_ROOM_EVENT_PEER_JOIN: %@", peerId_);
    }];
    [_meshRoom on:SKW_ROOM_EVENT_PEER_LEAVE callback:^(NSObject* arg) {
        NSString* peerId_ = (NSString*)arg;
        NSLog(@"SKW_ROOM_EVENT_PEER_LEAVE: %@", peerId_);
    }];
    [_meshRoom on:SKW_ROOM_EVENT_DATA callback:^(NSObject* arg) {
        SKWRoomDataMessage* msg = (SKWRoomDataMessage*)arg;
        NSString* peerId_ = msg.src;
        if ([msg.data isKindOfClass:[NSString class]]) {
            NSString* data = (NSString*)msg.data;
            NSLog(@"SKW_ROOM_EVENT_DATA(string): sender=%@, data=%@", peerId_, data);
            [self->_tableViewController setChatMessage:peerId_ text:data];
        }
    }];
    
}

//
// Action for leaveButton
//
- (IBAction)onLeaveButtonClicked:(id)sender {
    if (nil == _peer || nil == _meshRoom){
        return;
    }
    [_meshRoom close];
}

//
// Action for sendButton
//
- (IBAction)sendText:(id)sender {
    if (nil == _peer || nil  == _meshRoom) return;
    [_meshRoom send:_messageField.text];
    [_tableViewController setChatMessage:_strOwnId text:_messageField.text];
    _messageField.text = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSString * segueName = segue.identifier;
    if ([segueName isEqualToString:@"mesh_room_tableview"]) {
        _tableViewController = segue.destinationViewController;
    }
}

@end
