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

@interface DataSource : NSObject

@property (nonatomic, strong, readonly) NSArray *mediaItems;

+(instancetype) sharedInstance;

-(void)deleteMediaItem:(Media *) item;

@end
