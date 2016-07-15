//
//  UIImage+CameraControllerImageUtilities.h
//  Blocstagram
//
//  Created by Ryan Rizzo on 7/15/16.
//  Copyright © 2016 Ryan Rizzo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CameraControllerImageUtilities)

- (UIImage *) imageByScalingToSize:(CGSize)size andCroppingWithRect:(CGRect)rect;

@end
