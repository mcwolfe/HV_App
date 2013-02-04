//
//  HVCell.m
//  studentapp
//
//  Created by Rickard Fjeldseth on 2013-01-06.
//  Copyright (c) 2013 Högskolan Väst. All rights reserved.
//

#import "HVCell.h"
#import "HVCellBackground.h"

@implementation HVCell

@synthesize descriptionText;
@synthesize titleLabel;
@synthesize tagLabel;
@synthesize dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    NSLog(@"Skapar en HVCell!");
    if (self) {
        defaultLabelColor = [UIColor blackColor];
        defaultDateLabelColor = [UIColor lightGrayColor];
        self.backgroundColor = [UIColor clearColor];
        [self addTagLabelToSubview];
        [self addDateLabelToSubview];
        [self addTitleLabelToSubview];
        [self addDescriptionTextToSubview];
        
        self.backgroundView = [[HVCellBackground alloc] initAsSelected:NO];
        self.selectedBackgroundView = [[HVCellBackground alloc] initAsSelected:YES];
        self.textLabel.highlightedTextColor = [UIColor grayColor];
    }
    return self;
}

- (UIColor *)defaultLabelColor {
    return defaultLabelColor;
}

- (UIColor *)defaultDateLabelColor {
    return defaultDateLabelColor;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

- (CGRect)bounds {
    CGRect rect = [super bounds];
    rect.size.height = 70;
    return rect;
}

- (void)addTagLabelToSubview {
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:13];
    CGRect tagRect = self.contentView.bounds;
    tagRect.origin.x = 200;
    tagRect.origin.y = 0;
    tagRect.size.width = 100;
    tagRect.size.height = 20;
    
    tagLabel = [[UILabel alloc] initWithFrame:tagRect];
    tagLabel.textAlignment = NSTextAlignmentLeft;
    tagLabel.font = font;
    tagLabel.textAlignment = NSTextAlignmentRight;
    tagLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:tagLabel];
}

- (void)addTitleLabelToSubview {
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:13];
    CGRect tagRect = self.contentView.bounds;
    tagRect.origin.x = 7;
    tagRect.origin.y = 0;
    tagRect.size.width = 194;
    tagRect.size.height = 20;
    
    titleLabel = [[UILabel alloc] initWithFrame:tagRect];
    titleLabel.font = font;
    titleLabel.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:titleLabel];
}

- (void)addDescriptionTextToSubview {
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:11];
    CGRect textRect = CGRectMake(0, 10, 210, 50);
    
    descriptionText = [[UITextView alloc] initWithFrame:textRect];
    descriptionText.backgroundColor = [UIColor clearColor];
    descriptionText.font = font;
    descriptionText.editable = NO;
    descriptionText.userInteractionEnabled = NO;
    
    [self.contentView addSubview:descriptionText];
}

- (void)addDateLabelToSubview {
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:11];
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 56, 98, 12)];
    
    dateLabel.font = font;
    dateLabel.textAlignment = NSTextAlignmentRight;
    dateLabel.textColor = [UIColor lightGrayColor];
    dateLabel.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:dateLabel];
}

- (void)setSideColor:(UIColor *)color {
    HVCellBackground *bg = (HVCellBackground *)self.backgroundView;
    HVCellBackground *selectedBG = (HVCellBackground *)self.selectedBackgroundView;
    
    bg.sideColor         = color;
    selectedBG.sideColor = color;
    
    [self.backgroundView setNeedsDisplay];
    [self.selectedBackgroundView setNeedsDisplay];
}

- (void)markAsRead:(BOOL)hasBeenRead {
    if (hasBeenRead) {
        self.descriptionText.textColor = [UIColor lightGrayColor];
        self.titleLabel.textColor      = [UIColor lightGrayColor];
        self.tagLabel.textColor        = [UIColor lightGrayColor];
        self.dateLabel.textColor       = [UIColor lightGrayColor];
    } else {
        self.descriptionText.textColor = [self defaultLabelColor];
        self.titleLabel.textColor      = [self defaultLabelColor];
        self.tagLabel.textColor        = [self defaultLabelColor];
        self.dateLabel.textColor       = [self defaultDateLabelColor];
    }

    
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
}

@end
