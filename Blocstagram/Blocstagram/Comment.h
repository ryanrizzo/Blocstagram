//
//  Comment.h
//  Blocstagram
//
//  Created by Ryan Rizzo on 6/27/16.
//  Copyright © 2016 Ryan Rizzo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface Comment : NSObject

@property (nonatomic, strong) NSString *idNumber;

@property (nonatomic, strong) User *from;
@property (nonatomic, strong) NSString *text;


@end
