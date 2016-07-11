//
//  MediaTableViewCell.m
//  Blocstagram
//
//  Created by Ryan Rizzo on 6/28/16.
//  Copyright © 2016 Ryan Rizzo. All rights reserved.
//

#import "MediaTableViewCell.h"
#import "DataSource.h"
#import "LikeButton.h"

@interface MediaTableViewCell () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTapGestureRecognizer;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGestureRecognizer;

@property (nonatomic, strong) UIImageView *mediaImageView;
@property (nonatomic, strong) UILabel *usernameAndCaptionLabel;
@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) UILabel *likesLabel;

@property (nonatomic, strong) NSLayoutConstraint *imageHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *imageWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *usernameAndCaptionLabelHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *commentLabelHeightConstraint;

@property (nonatomic, strong) LikeButton *likeButton;


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
        
        self.mediaImageView.userInteractionEnabled = YES;
        
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFired:)];
        self.tapGestureRecognizer.delegate = self;
        [self.mediaImageView addGestureRecognizer:self.tapGestureRecognizer];
        
        
        self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressFired:)];
        self.longPressGestureRecognizer.delegate = self;
        [self.mediaImageView addGestureRecognizer:self.longPressGestureRecognizer];
        
        self.usernameAndCaptionLabel = [[UILabel alloc] init];
        self.usernameAndCaptionLabel.numberOfLines = 0;
        self.usernameAndCaptionLabel.backgroundColor = usernameLabelGray;
        
        self.commentLabel = [[UILabel alloc] init];
        self.commentLabel.numberOfLines = 0;
        self.commentLabel.backgroundColor = commentLabelGray;
        
        self.likesLabel = [[UILabel alloc] init];
        self.likesLabel.backgroundColor = usernameLabelGray;
        self.likesLabel.frame = CGRectMake(305, 15, 30, 20);
        
        self.likeButton = [[LikeButton alloc] init];
        [self.likeButton addTarget:self action:@selector(likePressed:) forControlEvents:UIControlEventTouchUpInside];
        self.likeButton.backgroundColor = usernameLabelGray;
        
        for (UIView *view in @[self.mediaImageView, self.usernameAndCaptionLabel, self.commentLabel, self.likeButton]) {
            
            [self.contentView addSubview:view];
            view.translatesAutoresizingMaskIntoConstraints = NO;
            
        }
        [self.usernameAndCaptionLabel addSubview: self.likesLabel];
        
       NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_mediaImageView, _usernameAndCaptionLabel, _commentLabel, _likeButton);
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_mediaImageView]|" options:kNilOptions metrics:nil views:viewDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_usernameAndCaptionLabel][_likeButton(==38)]|" options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:nil views:viewDictionary]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_commentLabel]|" options:kNilOptions metrics:nil views:viewDictionary]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_mediaImageView][_usernameAndCaptionLabel][_commentLabel]"
                                                                                 options:kNilOptions
                                                                                 metrics:nil
                                                                                   views:viewDictionary]];
        
        self.imageHeightConstraint = [NSLayoutConstraint constraintWithItem:_mediaImageView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1
                                                                   constant:100];
        self.imageHeightConstraint.identifier = @"Image height constraint";
        
        self.usernameAndCaptionLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_usernameAndCaptionLabel
                                                                                    attribute:NSLayoutAttributeHeight
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:nil
                                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                                   multiplier:1
                                                                                     constant:100];
        self.usernameAndCaptionLabelHeightConstraint.identifier = @"Username and caption label height constraint";
        
        self.commentLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_commentLabel
                                                                         attribute:NSLayoutAttributeHeight
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:nil
                                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                                        multiplier:1
                                                                          constant:100];
        self.commentLabelHeightConstraint.identifier = @"Comment label height constraint";
        
        [self.contentView addConstraints:@[self.imageHeightConstraint, self.usernameAndCaptionLabelHeightConstraint, self.commentLabelHeightConstraint]];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:animated];

    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:NO animated:animated];
}

#pragma mark - Image View

- (void) tapFired:(UITapGestureRecognizer *)sender {
    [self.delegate cell:self didTapImageView:self.mediaImageView];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return self.isEditing == NO;
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
            if(count % 2 == 0){
                paragraphStyle = evenParagraphStyle;
            }else{
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

- (void) layoutSubviews {
    [super layoutSubviews];
    
    if (!self.mediaItem) {
        return;
    }
    
    
    
        // Hide the line between cells
    self.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(self.bounds)/2.0, 0, CGRectGetWidth(self.bounds)/2.0);
}

- (void) updateConstraints {
    [super updateConstraints];
    
    // Before layout, calculate the intrinsic size of the labels (the size they "want" to be), and add 20 to the height for some vertical padding.
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX);
    CGSize usernameLabelSize = [self.usernameAndCaptionLabel sizeThatFits:maxSize];
    CGSize commentLabelSize = [self.commentLabel sizeThatFits:maxSize];
    
    self.usernameAndCaptionLabelHeightConstraint.constant = usernameLabelSize.height == 0 ? 0 : usernameLabelSize.height + 20;
    
    self.commentLabelHeightConstraint.constant = commentLabelSize.height == 0 ? 0 : commentLabelSize.height + 20;
    
    if (self.mediaItem.image.size.width > 0 && CGRectGetWidth(self.contentView.bounds) > 0) {
        self.imageHeightConstraint.constant = self.mediaItem.image.size.height / self.mediaItem.image.size.width * CGRectGetWidth(self.contentView.bounds);
    } else {
        self.imageHeightConstraint.constant = 350;
    }
}

- (void) setMediaItem:(Media *)mediaItem {
    
    _mediaItem = mediaItem;
    self.mediaImageView.image = _mediaItem.image;
    self.usernameAndCaptionLabel.attributedText = [self usernameAndCaptionString];
    
    self.commentLabel.attributedText = [self commentString];
    self.likeButton.likeButtonState = mediaItem.likeState;
    
    [self.delegate likesCount:mediaItem withCompletion:^(NSInteger *numberOfLikes){
        self.likesLabel.text = [NSString stringWithFormat:@"%ld",(long)self.mediaItem.likes];
    }];
    
    
    [self setNeedsUpdateConstraints];
}

#pragma mark - Liking

- (void) likePressed:(UIButton *)sender {
    [self.delegate cellDidPressLikeButton:self];
}


+ (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width {
    // Make a cell
    MediaTableViewCell *layoutCell = [[MediaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"layoutCell"];
   
    layoutCell.mediaItem = mediaItem;
    
    layoutCell.frame = CGRectMake(0, 0, width, CGRectGetHeight(layoutCell.frame));

    [layoutCell setNeedsLayout];
    [layoutCell layoutIfNeeded];
    
    // Get the actual height required for the cell
    return CGRectGetMaxY(layoutCell.commentLabel.frame);
}

- (void) longPressFired:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self.delegate cell:self didLongPressImageView:self.mediaImageView];
    }
}

@end
