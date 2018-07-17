//
//  TextChatTableViewController.h
//  eclwebrtc-ios-sample-sfu-textchat
//
#import <UIKit/UIKit.h>

@interface TextChatTableViewController : UITableViewController <UITextFieldDelegate>

- (void)setChatMessage:(NSString*)src text:(NSString*)text;

@end
