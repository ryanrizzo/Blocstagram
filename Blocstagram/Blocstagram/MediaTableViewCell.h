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

@class Media;

@interface MediaTableViewCell : UITableViewCell

@property (nonatomic, strong) Media *mediaItem;

+ (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width;

@end
