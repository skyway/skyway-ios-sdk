//
//  ViewController.m
//  eclwebrtc-ios-sample-p2p-textchat
//
//

#import "ViewController.h"
#import "PeerListViewController.h"

//
// Set your APIkey and Domain
//
static NSString *const kAPIkey = @"yourAPIKEY";
static NSString *const kDomain = @"yourDomain";

@interface ViewController () {
    SKWPeer*			_peer;
    SKWDataConnection*	_dataConnection;
    
    NSString*			_strOwnId;
    BOOL				_bConnected;
    NSArray*			_aryDataTypeButtonTitles;
    
    //
    // Type of sample data
    // (0:String, 1:Number, 2:Array, 3:Map, 4:Binary)
    //
    NSUInteger          _uiDataType;
    
}

@property (weak, nonatomic) IBOutlet UILabel*       idLabel;
@property (weak, nonatomic) IBOutlet UIButton*      actionButton;
@property (weak, nonatomic) IBOutlet UIButton*      dataTypeButton;
@property (weak, nonatomic) IBOutlet UIButton*      sendButton;
@property (weak, nonatomic) IBOutlet UITextView*    messageView;
@property (weak, nonatomic) IBOutlet UIImageView*   imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _aryDataTypeButtonTitles = @[
                      @"Hello SkyWay. (String)",
                      @"3.14 (Number)",
                      @"[1,2,3] (Array)",
                      @"{'one':1,'two':2} (Map)",
                      @"send Image (Binary)"
                      ];

    _uiDataType = 0;
    
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
    
    [_peer on:SKW_PEER_EVENT_OPEN callback:^(NSObject* obj) {
        
        // Show my ID
        self->_strOwnId = (NSString*) obj;
        self->_idLabel.text = self->_strOwnId;
        
    }];
    
    [_peer on:SKW_PEER_EVENT_CONNECTION callback:^(NSObject* obj) {
        if (YES == [obj isKindOfClass:[SKWDataConnection class]]) {
            self->_dataConnection = (SKWDataConnection *)obj;
            [self setDataCallbacks];
        }
    }];
    
    [_peer on:SKW_PEER_EVENT_CLOSE callback:^(NSObject* obj) {}];
    [_peer on:SKW_PEER_EVENT_DISCONNECTED callback:^(NSObject* obj) {}];
    [_peer on:SKW_PEER_EVENT_ERROR callback:^(NSObject* obj) {}];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    [self updateUI];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    [super viewDidDisappear:animated];
}

- (void)dealloc {
    _strOwnId = nil;
    [self unsetDataCallbacks];
    _dataConnection = nil;
    [self unsetPeerCallbacks];
    _peer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
// Set callbacks for DATACONNECTION_EVENTs
//
- (void)setDataCallbacks {
    if (nil == _dataConnection) {
        return;
    }
    
    [_dataConnection on:SKW_DATACONNECTION_EVENT_OPEN callback:^(NSObject* obj) {
        self->_bConnected = YES;
        [self updateUI];
        [self appendLog:@"Connected."];         
     }];
    
    [_dataConnection on:SKW_DATACONNECTION_EVENT_CLOSE callback:^(NSObject* obj) {
        self->_bConnected = NO;
        [self updateUI];
        [self unsetDataCallbacks];
        self->_dataConnection = nil;
        [self appendLog:@"Disconnected."];
     }];
    
    [_dataConnection on:SKW_DATACONNECTION_EVENT_DATA callback:^(NSObject* obj) {
        NSString* strData = nil;
        
        if ([obj isKindOfClass:[NSString class]]) { // String
            strData = (NSString *)obj;
        }
        else if ([obj isKindOfClass:[NSNumber class]]) { // Number
            NSNumber* numData = (NSNumber *)obj;
            strData = [NSString stringWithFormat:@"[%s]%@", [numData objCType], numData];
        }
        else if ([obj isKindOfClass:[NSArray class]]) { // Array
            NSArray* aryData = (NSArray *)obj;
            strData = [NSString stringWithFormat:@"%@", aryData];
        }
        else if ([obj isKindOfClass:[NSDictionary class]]) { // Map
            NSDictionary* dctData = (NSDictionary *)obj;
            strData = [NSString stringWithFormat:@"%@", dctData];
        }
        else if ([obj isKindOfClass:[NSData class]]) { // Binary
            NSData* datData = (NSData *)obj;
            UIImage* image = [[UIImage alloc] initWithData:datData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->_imageView setImage:image];
            });
            strData = @"Received Image (displayed below)";
        }
        
        [self appendLog:[NSString stringWithFormat:@"Remote: %@", strData]];
        
    }];

    [_dataConnection on:SKW_DATACONNECTION_EVENT_ERROR callback:^(NSObject* obj) { }];
    
}

//
// Unset callbacks for DATACONNECTION_EVENTs
//
- (void)unsetDataCallbacks {
    if(nil == _dataConnection) {
        return;
    }
    
    [_dataConnection on:SKW_DATACONNECTION_EVENT_OPEN callback:nil];
    [_dataConnection on:SKW_DATACONNECTION_EVENT_DATA callback:nil];
    [_dataConnection on:SKW_DATACONNECTION_EVENT_CLOSE callback:nil];
    [_dataConnection on:SKW_DATACONNECTION_EVENT_ERROR callback:nil];
}

//
// Open a DataConnection
//
- (void) didSelectPeer:(NSString *)peerId {
    SKWConnectOption* option = [[SKWConnectOption alloc] init];
    option.label = @"chat";
    option.metadata = @"{'message': 'hi'}";
    option.serialization = SKW_SERIALIZATION_BINARY;
    
    _dataConnection = [_peer connectWithId:peerId options:option];
    [self setDataCallbacks];
}

//
// Update UIs
//
- (void)updateUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* title = (self->_bConnected) ? @"Disconnect" : @"Connect";
        [self->_actionButton setTitle:title forState:UIControlStateNormal];
        [self->_sendButton setEnabled:self->_bConnected];
    });
}

//
// Append a string to messageView
//
- (void)appendLog:(NSString*)str{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString* newStr = [NSString stringWithFormat:@"%@\n%@",self->_messageView.text,str];
        [self->_messageView setText:newStr];
        
        NSRange rng = NSMakeRange(self->_messageView.text.length + 1, 0);
        [self->_messageView scrollRangeToVisible:rng];
    });
}

//
// IBActions
//

//
// Action for actionButton
// Connect/disconnect a DataConnection
//
- (IBAction)onActionButtonClicked:(id)sender {
    
    if(nil == _dataConnection) {
        
        //
        // Select remote peer & open a DataConnection
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
    
    else {
        
        //
        // Close a DataConnection
        //
        
        [_dataConnection close];
        _dataConnection = nil;
    }
}

//
// Action for dataTypeButton
// Select sample data to send
//
- (IBAction)onDataTypeButtonClicked:(id)sender {
    
    // Show sample datas using ActionSheet
    UIAlertController* ac = [UIAlertController
                             alertControllerWithTitle:@"Select Sample Data  (Data type)"
                             message:@""
                             preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* aaCancel = [UIAlertAction
                               actionWithTitle:@"Cancel"
                               style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction *action){ }];
    [ac addAction:aaCancel];
    
    NSUInteger count = _aryDataTypeButtonTitles.count;
    for(int i = 0; i < count; ++i){
        NSString* title = _aryDataTypeButtonTitles[i];
        UIAlertAction* aaTypes = [UIAlertAction
                                  actionWithTitle:title
                                  style:UIAlertActionStyleDestructive
                                  handler:^(UIAlertAction *action) {
                                      self->_uiDataType = i;
                                      [self->_dataTypeButton setTitle:title forState:UIControlStateNormal];
                                  }];
        [ac addAction:aaTypes];
    }
    
    [self presentViewController:ac animated:YES completion:nil];
}

//
// Action for sendButton
// Send sample data over a DataConnection
//
- (IBAction)onSendButtonClicked:(id)sender {
    BOOL bResult = NO;
    NSString* strMsg = [NSString alloc];
    
    switch(_uiDataType){
        case 0:{   // String
            NSString* strData = @"Hello SkyWay.";
            bResult = [_dataConnection send:strData];
            strMsg = [NSString stringWithFormat:@"%@", strData];
            break;
        }
        case 1:{ // Number
            NSNumber* numData = [NSNumber numberWithDouble:3.14];
            bResult = [_dataConnection send:numData];
            strMsg = [NSString stringWithFormat:@"%@", numData];
            break;
        }
        case 2:{ // Array
            NSArray* aryData = @[@1,@2,@3,];
            bResult = [_dataConnection send:aryData];
            strMsg = [NSString stringWithFormat:@"%@", aryData];
            break;
        }
        case 3:{ // Map
            NSDictionary* dctData = @{@"one": @1, @"two": @2,};
            bResult = [_dataConnection send:dctData];
            strMsg = [NSString stringWithFormat:@"%@", dctData];
            break;
        }
        case 4:{ // Binary
            UIImage *image = [UIImage imageNamed:@"image.png"];
            NSData* pngData = [[NSData alloc] initWithData: UIImagePNGRepresentation(image)];
            bResult = [_dataConnection send:pngData];
            strMsg = @"Send Image";
            break;
        }
        default:
            break;
    }
    
    if (bResult) {
        [self appendLog:[NSString stringWithFormat:@"You: %@", strMsg]];
    }
}


@end
