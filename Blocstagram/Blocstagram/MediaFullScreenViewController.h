//
//  MediaFullScreenViewController.h
//  Blocstagram
//
//  Created by Ryan Rizzo on 7/5/16.
//  Copyright © 2016 Ryan Rizzo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media;

@interface MediaFullScreenViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

- (instancetype) initWithMedia:(Media *)media;

- (void) centerScrollView;

-(IBAction)shareButtonPressed:(id)sender;

@end