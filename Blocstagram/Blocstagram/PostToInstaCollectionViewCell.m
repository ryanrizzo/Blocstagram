//
//  PostToInstaCollectionViewCell.m
//  Blocstagram
//
//  Created by Ryan Rizzo on 7/20/16.
//  Copyright © 2016 Ryan Rizzo. All rights reserved.
//

#import "PostToInstaCollectionViewCell.h"

static UIColor *backgroundColor;

@implementation PostToInstaCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        CGFloat thumbnailEdgeSize = 128;
        static NSInteger imageViewTag = 1000;
        static NSInteger labelTag = 1001;
        
            self.thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, thumbnailEdgeSize, thumbnailEdgeSize)];
            self.thumbnail.contentMode = UIViewContentModeScaleAspectFill;
            self.thumbnail.clipsToBounds = YES;
            
            [self.contentView addSubview:self.thumbnail];
        
            self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, thumbnailEdgeSize, thumbnailEdgeSize, 20)];
            self.label.textAlignment = NSTextAlignmentCenter;
            self.label.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10];
            [self.contentView addSubview:self.label];
    
    self.label.tag = labelTag;
    self.thumbnail.tag = imageViewTag;


    }
    
    return self;
}

//set background color

//flow layout?

//

@end
