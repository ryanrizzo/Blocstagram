//
//  DataSource.h
//  Blocstagram
//
//  Created by Ryan Rizzo on 6/27/16.
//  Copyright © 2016 Ryan Rizzo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Media.h"

@interface DataSource : NSObject

+(instancetype) sharedInstance;
-(void)didTryToDeleteWithMedia:(Media *) item;
@property (nonatomic, strong, readonly) NSArray *mediaItems;

@end
