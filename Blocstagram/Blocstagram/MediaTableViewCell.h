//
//  MediaTableViewCell.h
//  Blocstagram
//
//  Created by Ryan Rizzo on 6/28/16.
//  Copyright © 2016 Ryan Rizzo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Media.h"
#import "Comment.h"
#import "User.h"

@class Media, MediaTableViewCell;

@protocol MediaTableViewCellDelegate <NSObject>
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;

- (void) cell:(MediaTableViewCell *)cell didTapImageView:(UIImageView *)imageView;
- (void) cell:(MediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView;

@end

@interface MediaTableViewCell : UITableViewCell

@property (nonatomic, strong) Media *mediaItem;

@property (nonatomic, weak) id <MediaTableViewCellDelegate> delegate;

+ (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width traitCollection:(UITraitCollection *) traitCollection;

@end
