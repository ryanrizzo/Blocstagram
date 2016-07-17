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

@property (nonatomic, strong) Media *media;

- (instancetype) initWithMedia:(Media *)media;

- (void) centerScrollView;

-(void) recalculateZoomScale;

-(IBAction)shareButtonPressed:(id)sender;

@end