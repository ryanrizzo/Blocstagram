//
//  Media.h
//  Blocstagram
//
//  Created by Ryan Rizzo on 6/27/16.
//  Copyright © 2016 Ryan Rizzo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LikeButton.h"

typedef NS_ENUM(NSInteger, MediaDownloadState) {
    MediaDownloadStateNeedsImage             = 0,
    MediaDownloadStateDownloadInProgress     = 1,
    MediaDownloadStateNonRecoverableError    = 2,
    MediaDownloadStateHasImage               = 3
};

@class User;

@interface Media : NSObject <NSCoding>

@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSURL *mediaURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, assign) NSInteger *likes;

@property (nonatomic, assign) LikeState likeState;

@property (nonatomic, assign) MediaDownloadState downloadState;

@property (nonatomic, strong) NSString *temporaryComment;

- (instancetype) initWithDictionary:(NSDictionary *)mediaDictionary;


@end
