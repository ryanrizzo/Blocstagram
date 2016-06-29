//
//  MediaTableViewCell.m
//  Blocstagram
//
//  Created by Ryan Rizzo on 6/28/16.
//  Copyright © 2016 Ryan Rizzo. All rights reserved.
//

#import "MediaTableViewCell.h"
#import "DataSource.h"

@interface MediaTableViewCell ()

@property (nonatomic, strong) UIImageView *mediaImageView;
@property (nonatomic, strong) UILabel *usernameAndCaptionLabel;
@property (nonatomic, strong) UILabel *commentLabel;

@end

static UIColor *firstCommentColor;
static UIFont *lightFont;
static UIFont *boldFont;
static UIColor *usernameLabelGray;
static UIColor *commentLabelGray;
static UIColor *linkColor;
static NSParagraphStyle *paragraphStyle;
static NSParagraphStyle *evenParagraphStyle;
static NSParagraphStyle *oddParagraphStyle;

@implementation MediaTableViewCell

+ (void)load {
    lightFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
    boldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
    usernameLabelGray = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1]; /*#eeeeee*/
    firstCommentColor = [UIColor orangeColor];
    commentLabelGray = [UIColor colorWithRed:0.898 green:0.898 blue:0.898 alpha:1]; /*#e5e5e5*/
    linkColor = [UIColor colorWithRed:0.345 green:0.314 blue:0.427 alpha:1]; /*#58506d*/
    
    NSMutableParagraphStyle *evenMutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    evenMutableParagraphStyle.headIndent = 20.0;
    evenMutableParagraphStyle.firstLineHeadIndent = 20.0;
    evenMutableParagraphStyle.tailIndent = -20.0;
    evenMutableParagraphStyle.paragraphSpacingBefore = 5;
    evenMutableParagraphStyle.alignment = NSTextAlignmentLeft;
    
    evenParagraphStyle = evenMutableParagraphStyle;
    
    paragraphStyle = evenMutableParagraphStyle;
    
    NSMutableParagraphStyle *oddMutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    oddMutableParagraphStyle.headIndent = 20.0;
    oddMutableParagraphStyle.firstLineHeadIndent = 20.0;
    oddMutableParagraphStyle.tailIndent = -20.0;
    oddMutableParagraphStyle.paragraphSpacingBefore = 5;
    oddMutableParagraphStyle.alignment = NSTextAlignmentRight;
    
    oddParagraphStyle = oddMutableParagraphStyle;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Initialization code
        self.mediaImageView = [[UIImageView alloc] init];
        self.usernameAndCaptionLabel = [[UILabel alloc] init];
        self.usernameAndCaptionLabel.numberOfLines = 0;
        self.usernameAndCaptionLabel.backgroundColor = usernameLabelGray;
        
        self.commentLabel = [[UILabel alloc] init];
        self.commentLabel.numberOfLines = 0;
        self.commentLabel.backgroundColor = commentLabelGray;
        
        for (UIView *view in @[self.mediaImageView, self.usernameAndCaptionLabel, self.commentLabel]) {
            [self.contentView addSubview:view];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSAttributedString *) usernameAndCaptionString {
    // #1
    CGFloat usernameFontSize = 15;
    
    // #2 - Make a string that says "username caption"
    NSString *baseString = [NSString stringWithFormat:@"%@ %@", self.mediaItem.user.userName, self.mediaItem.caption];
    NSRange baseRange = [baseString rangeOfString:self.mediaItem.caption];
    
    // #3 - Make an attributed string, with the "username" bold
    NSMutableAttributedString *mutableUsernameAndCaptionString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [lightFont fontWithSize:usernameFontSize], NSParagraphStyleAttributeName : paragraphStyle}];
    
    // #4
    NSRange usernameRange = [baseString rangeOfString:self.mediaItem.user.userName];
    [mutableUsernameAndCaptionString addAttribute:NSFontAttributeName value:[boldFont fontWithSize:usernameFontSize] range:usernameRange];
    [mutableUsernameAndCaptionString addAttribute:NSForegroundColorAttributeName value:linkColor range:usernameRange];
    [mutableUsernameAndCaptionString addAttribute:NSKernAttributeName value:@(1.4) range:baseRange];
    
    return mutableUsernameAndCaptionString;
}

- (NSAttributedString *) commentString {
    NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] init];
    NSInteger count = 0;
    for (Comment *comment in self.mediaItem.comments) {
        
        if(comment != [self.mediaItem.comments firstObject]){
            if(count%2==0){
                paragraphStyle = evenParagraphStyle;
                NSLog(@"%ld", (long)count);
            }else{
                NSLog(@"odd this time");
                paragraphStyle = oddParagraphStyle;
            }
            
            // Make a string that says "username comment" followed by a line break
            NSString *baseString = [NSString stringWithFormat:@"%@ %@\n", comment.from.userName, comment.text];
        
            // Make an attributed string, with the "username" bold
        
            NSMutableAttributedString *oneCommentString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : lightFont, NSParagraphStyleAttributeName : paragraphStyle}];
        
            NSRange usernameRange = [baseString rangeOfString:comment.from.userName];
            [oneCommentString addAttribute:NSFontAttributeName value:boldFont range:usernameRange];
            [oneCommentString addAttribute:NSForegroundColorAttributeName value:linkColor range:usernameRange];
        
            [commentString appendAttributedString:oneCommentString];
           

            count = count+1;
            
        }else{
            
                        // Make a string that says "username comment" followed by a line break
            NSString *baseString = [NSString stringWithFormat:@"%@ %@\n", comment.from.userName, comment.text];
            
            
            
            // Make an attributed string, with the "username" bold
            
            NSMutableAttributedString *oneCommentString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : lightFont, NSParagraphStyleAttributeName : paragraphStyle}];
            
            
            NSRange usernameRange = [baseString rangeOfString:comment.from.userName];
            NSRange orangeRange = [baseString rangeOfString:comment.text];
            
            [oneCommentString addAttribute:NSFontAttributeName value:boldFont range:usernameRange];
            [oneCommentString addAttribute:NSForegroundColorAttributeName value:linkColor range:usernameRange];
            
            [oneCommentString addAttribute:NSForegroundColorAttributeName value:firstCommentColor range:orangeRange];
            
            [commentString appendAttributedString:oneCommentString];
            
            count = count+1;
        }
    
    }
    paragraphStyle = evenParagraphStyle;
    return commentString;
}

- (CGSize) sizeOfString:(NSAttributedString *)string {
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.contentView.bounds) - 40, 0.0);
    CGRect sizeRect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    sizeRect.size.height += 20;
    sizeRect = CGRectIntegral(sizeRect);
    return sizeRect.size;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    if (!self.mediaItem) {
        return;
    }
    
    CGFloat imageHeight = self.mediaItem.image.size.height / self.mediaItem.image.size.width * CGRectGetWidth(self.contentView.bounds);
    self.mediaImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), imageHeight);
    
    CGSize sizeOfUsernameAndCaptionLabel = [self sizeOfString:self.usernameAndCaptionLabel.attributedText];
    self.usernameAndCaptionLabel.frame = CGRectMake(0, CGRectGetMaxY(self.mediaImageView.frame), CGRectGetWidth(self.contentView.bounds), sizeOfUsernameAndCaptionLabel.height);
    
    CGSize sizeOfCommentLabel = [self sizeOfString:self.commentLabel.attributedText];
    self.commentLabel.frame = CGRectMake(0, CGRectGetMaxY(self.usernameAndCaptionLabel.frame), CGRectGetWidth(self.bounds), sizeOfCommentLabel.height);
    
    // Hide the line between cells
    self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.bounds)/2.0, 0, CGRectGetWidth(self.bounds)/2.0);
}

- (void) setMediaItem:(Media *)mediaItem {
    
    _mediaItem = mediaItem;
    self.mediaImageView.image = _mediaItem.image;
    self.usernameAndCaptionLabel.attributedText = [self usernameAndCaptionString];
    
    self.commentLabel.attributedText = [self commentString];

}

+ (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width {
    // Make a cell
    MediaTableViewCell *layoutCell = [[MediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"layoutCell"];
    
    // Set it to the given width, and the maximum possible height
    layoutCell.frame = CGRectMake(0, 0, width, CGFLOAT_MAX);
    
    // Give it the media item
    layoutCell.mediaItem = mediaItem;
    
    // Make it adjust the image view and labels
    [layoutCell layoutSubviews];
    
    // The height will be wherever the bottom of the comments label is
    return CGRectGetMaxY(layoutCell.commentLabel.frame);
}

@end
