//
//  RoomCollectionViewController.m
//  eclwebrtc-ios-sample-mesh-videochat
//
//

#import "RoomCollectionViewController.h"

@interface RoomCollectionViewController () {
    NSLock*                 _lock;
    NSMutableArray*         _aryMediaStreams;
    NSMutableDictionary*    _aryVideoViews;
}

@end

@implementation RoomCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    _lock = [[NSLock alloc] init];
    _aryMediaStreams = [NSMutableArray new];
    _aryVideoViews = [NSMutableDictionary new];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addMediaStream:(SKWMediaStream*)stream {
    NSString* msKey = [NSString stringWithFormat:@"%@:%@", stream.peerId, stream.label];
    NSLog(@"-addMediaStream: [key=%@]", msKey);

    [_lock lock];
    [_aryMediaStreams addObject:stream];
    [self.collectionView reloadData];
    [_lock unlock];
}

- (void)removeMediaStream:(SKWMediaStream*)stream {
    NSString* msKey = [NSString stringWithFormat:@"%@:%@", stream.peerId, stream.label];
    NSLog(@"-removeMediaStream: [key=%@]", msKey);

    [_lock lock];
    SKWVideo* video = [_aryVideoViews objectForKey:msKey];
    if (nil != video) {
        NSLog(@"removing video: %@", video);
        [stream removeVideoRenderer:video track:0];
        [video removeFromSuperview];
        [_aryVideoViews removeObjectForKey:msKey];
    }
    [_aryMediaStreams removeObject:stream];
    [self.collectionView reloadData];
    [_lock unlock];
}

- (void)removePeerStreams:(NSString*)peerId {
    __block SKWMediaStream* stream = nil;

    [_lock lock];
    [_aryMediaStreams enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL* stop) {
        SKWMediaStream* ms = (SKWMediaStream*)obj;
        if ([ms.peerId isEqualToString:peerId]) {
            stream = ms;
            *stop = YES;
        }
    }];
    [_lock unlock];

    if (nil == stream) return;

    [self removeMediaStream:stream];
}

- (void)removeAllMediaStreams {
    [_lock lock];
    [_aryMediaStreams enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL* stop) {
        SKWMediaStream* stream = (SKWMediaStream*)obj;
        NSString* msKey = [NSString stringWithFormat:@"%@:%@", stream.peerId, stream.label];
        SKWVideo* video = [self->_aryVideoViews objectForKey:msKey];
        if (nil != video) {
            [stream removeVideoRenderer:video track:0];
            [video removeFromSuperview];
            [self->_aryVideoViews removeObjectForKey:msKey];
        }
    }];
    NSAssert(0 == _aryVideoViews.count, @"Video Views leaked.");
    [_aryMediaStreams removeAllObjects];
    [self.collectionView reloadData];
    [_lock unlock];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _aryMediaStreams.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    // Configure the cell
    UIView* v = [cell viewWithTag:1];
    if (nil != v) {
        SKWMediaStream* stream = [_aryMediaStreams objectAtIndex:indexPath.row];
        if (nil != stream) {
            NSString* msKey = [NSString stringWithFormat:@"%@:%@", stream.peerId, stream.label];
            SKWVideo* video = [_aryVideoViews objectForKey:msKey];
            if (nil == video) {
                video = [[SKWVideo alloc] initWithFrame:cell.bounds];
                [stream addVideoRenderer:video track:0];
                [_aryVideoViews setObject:video forKey:msKey];
            }
            video.frame = cell.bounds;
            [v addSubview:video];
            [video setNeedsLayout];

            UILabel* lbl = [cell viewWithTag:2];
            if (nil != lbl) {
                lbl.text = stream.peerId;
                [v bringSubviewToFront:lbl];
            }
        }
    }

    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

@end
