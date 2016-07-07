//
//  DataSource.h
//  Blocstagram
//
//  Created by Ryan Rizzo on 6/27/16.
//  Copyright © 2016 Ryan Rizzo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Media.h"

@class Media;

typedef void (^NewItemCompletionBlock)(NSError *error);

@interface DataSource : NSObject

@property (nonatomic, strong, readonly) NSArray *mediaItems;

 @property (nonatomic, strong, readonly) NSString *accessToken;

+(instancetype) sharedInstance;

+(NSString *) instagramClientID;

-(void)deleteMediaItem:(Media *) item;

- (void) requestNewItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler;

- (void) requestOldItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler;

- (void) downloadImageForMediaItem:(Media *)mediaItem;

- (void) toggleLikeOnMediaItem:(Media *)mediaItem withCompletionHandler:(void (^)(void))completionHandler;

- (NSUInteger) downloadLikes:(Media *)mediaItem;

@end
