//
//  TextChatTableViewController.h
//  SkyWaySDK_Samples_iOS
//
#import <UIKit/UIKit.h>

@interface TextChatTableViewController : UITableViewController <UITextFieldDelegate>

- (void)setChatMessage:(NSString*)src text:(NSString*)text;

@end
