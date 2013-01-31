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

@synthesize titleLabel;
@synthesize tagLabel;
@synthesize dateLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addTagLabelToSubview];
        [self addDateLabelToSubview];
        [self addTitleLabelToSubview];
        
        self.backgroundView = [[HVCellBackground alloc] initAsSelected:NO];
        self.selectedBackgroundView = [[HVCellBackground alloc] initAsSelected:YES];
        self.textLabel.highlightedTextColor = [UIColor grayColor];
        [self modifyTextLabel];
    
        //[self.contentView addSubview:self.tagLabel];
    }
    
    return self;
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

- (CGRect)bounds {
    CGRect rect = [super bounds];
    rect.size.height = 70;
    return rect;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)addTagLabelToSubview {
    
    CGRect tagRect = self.contentView.bounds;
    tagRect.origin.x = (tagRect.size.width / 4) * 3;
    tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(tagRect.origin.x, tagRect.origin.y, tagRect.size.width / 4, 25)];
    tagLabel.textAlignment = NSTextAlignmentLeft;
    tagLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:tagLabel];
}

- (void)addTitleLabelToSubview {
    CGRect tagRect = self.contentView.bounds;
    tagRect.origin.x = 6;
    tagRect.origin.y = 0;
    tagRect.size.width = 200;
    tagRect.size.height = 20;
    
    titleLabel = [[UILabel alloc] initWithFrame:tagRect];
    titleLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:titleLabel];
}

- (void)addDateLabelToSubview {
    UIFont *font = [[UIFont alloc] init];
    font = [UIFont fontWithName:@"Helvetica"
                           size:11];

    
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
    
    //[self.backgroundView setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
}

-(void)modifyTextLabel{
    self.textLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
    
}

@end
