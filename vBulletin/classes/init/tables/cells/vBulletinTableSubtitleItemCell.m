/*!
 * vBulletin for iPhone
 * Copyright 2011 Ken Iovino. All Rights Reserved.
 *
 * This application and it's source code is owned and operated by Ken Iovino. Use of this 
 * application and it's source code is strictly prohibited unless otherwise specified in a written 
 * agreement.
 *
 * This file may not be redistributed in whole or significant part.
 */

// Class Header File
#import "vBulletinTableSubtitleItemCell.h"

// Table Item
#import "vBulletinTableSubtitleItem.h"

// Application Stylesheet
#import "vBulletinStyleSheet.h"

// The with of the cell's icon
static const CGFloat ICON_WIDTH = 22;

// The margin of the cell's icon
static const CGFloat ICON_MARGIN = 40;

// The padding of the cell
static const CGFloat CELL_PADDING = 10;

// The verticle line spacing between text
static const CGFloat LINE_SPACING = 2;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation vBulletinTableSubtitleItemCell

@synthesize bgViewSelected  = _bgViewSelected;
@synthesize selectBgImage   = _selectBgImage;
@synthesize normalBgImage   = _normalBgImage;
@synthesize disclosureImage = _disclosureImage;
    
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSObject

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
    if (self) {
        // setup the custom background images for the cells
        self.bgViewSelected = [[UIView alloc] init];
        self.normalBgImage  = 
            [[UIImageView alloc] initWithImage:vBStyleImage(@"/bgs/forumcell_bg.png")];
        self.selectBgImage  = 
            [[UIImageView alloc] initWithImage:vBStyleImage(@"/bgs/forumcell_selected_bg.png")];

        // assign the images to their respected views
        self.bgViewSelected = self.selectBgImage;
        self.backgroundView = self.normalBgImage;            

        // hide the selected view by default
        [self.bgViewSelected setAlpha:0];

        // set the contentview to be opaque for performance purposes
        [self.contentView setOpaque:YES];
        [self.contentView addSubview:self.bgViewSelected];
        
        // create the disclosure icon and add it to the cell
        self.disclosureImage = 
            [[UIImageView alloc] initWithImage:vBStyleImage(@"/icons/disclosure.png") 
                              highlightedImage:vBStyleImage(@"/icons/disclosure_selected.png")];
        [self.contentView addSubview:self.disclosureImage];

    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setObject:(id)object {
    if (_item != object) {
        [super setObject:object];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell Public

////////////////////////////////////////////////////////////////////////////////////////////////////
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object {    
    vBulletinTableSubtitleItem * item = object;
    CGSize titleSize  = [item.text sizeWithFont:TTSTYLEVAR(forumTableHeaderTitleFont)
                              constrainedToSize:CGSizeMake(260, CGFLOAT_MAX)
                                  lineBreakMode:UILineBreakModeWordWrap];
    CGSize detailSize = [item.subtitle sizeWithFont:TTSTYLEVAR(forumTableHeaderDescFont)
                                  constrainedToSize:CGSizeMake(260, CGFLOAT_MAX)
                                      lineBreakMode:UILineBreakModeWordWrap];
    return titleSize.height + detailSize.height + LINE_SPACING + CELL_PADDING * 2;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
    [super layoutSubviews];

    // begin the cell's title label
    NSInteger titleWidth = self.frame.size.width - CELL_PADDING * 2 - ICON_MARGIN;
    CGRect titleFrame    = CGRectMake(ICON_MARGIN, CELL_PADDING, titleWidth, 15);
    CGSize labelMaxSize  = CGSizeMake(titleWidth, CGFLOAT_MAX);    
    
    self.textLabel.frame           = titleFrame;
    self.textLabel.font            = TTSTYLEVAR(forumTableCellTitleFont);
    self.textLabel.backgroundColor = TTSTYLEVAR(forumTableCellTitleBackgroundColor);
    self.textLabel.textColor       = TTSTYLEVAR(forumTableCellTitleTextColor);
    self.textLabel.shadowColor     = TTSTYLEVAR(forumTableCellTitleShadowColor);
    self.textLabel.shadowOffset    = TTSTYLEVAR(forumTableCellTitleShadowOffset);
    self.textLabel.numberOfLines   = 99;
    
    // calulate the width & height based on the title's value
    CGSize titleSize = [self.textLabel.text sizeWithFont:self.textLabel.font 
                                       constrainedToSize:labelMaxSize 
                                           lineBreakMode:UILineBreakModeWordWrap]; 
    
    // adjust the title's height in case we need more lines
    CGRect adjTitleFrame      = self.textLabel.frame;
    adjTitleFrame.size.height = titleSize.height;
    self.textLabel.frame      = adjTitleFrame;
    
    // begin the cell's description label
    CGRect detailFrame   = titleFrame; // use the title's frame as the default
    detailFrame.origin.y = 
    self.textLabel.frame.origin.y + self.textLabel.frame.size.height + LINE_SPACING;
    
    self.detailTextLabel.frame           = detailFrame;
    self.detailTextLabel.font            = TTSTYLEVAR(forumTableCellDetailFont);
    self.detailTextLabel.backgroundColor = TTSTYLEVAR(forumTableCellDetailBackgroundColor);
    self.detailTextLabel.textColor       = TTSTYLEVAR(forumTableCellDetailTextColor);
    self.detailTextLabel.shadowColor     = TTSTYLEVAR(forumTableCellDetailShadowColor);
    self.detailTextLabel.shadowOffset    = TTSTYLEVAR(forumTableCellDetailShadowOffset);
    self.detailTextLabel.numberOfLines   = 99;
    
    // calulate the width & height based on the description's value
    CGSize detailSize = [self.detailTextLabel.text sizeWithFont:self.detailTextLabel.font 
                                              constrainedToSize:labelMaxSize
                                                  lineBreakMode:UILineBreakModeWordWrap]; 
    
    // adjust the description's height in case we need more lines
    CGRect adjDetailFrame      = self.detailTextLabel.frame;
    adjDetailFrame.size.height = detailSize.height;
    self.detailTextLabel.frame = adjDetailFrame;
    
    // setup the cell's background
    self.bgViewSelected.frame = 
    CGRectMake(0, 0, self.frame.size.width, 
               self.detailTextLabel.frame.origin.y + detailSize.height + CELL_PADDING);
    
    [self.contentView sendSubviewToBack:self.bgViewSelected];
    [self.contentView sendSubviewToBack:self.backgroundView];

    // setup the bottom border
    // self.bottomBorder.frame = CGRectMake(0, 1/*bgFrame.size.height - 2*/, self.frame.size.width, 1);
    // self.bottomBorder.backgroundColor =  [UIColor whiteColor];
    // [self.contentView addSubview:self.bottomBorder];
    
    // position the cell's left icon
    NSInteger iconXax     = self.bgViewSelected.frame.size.height / 2 - ICON_WIDTH / 2;    
    NSInteger iconYax     = ICON_MARGIN / 2 - ICON_WIDTH / 2;
    self.imageView2.frame = CGRectMake(floorf(iconYax), floorf(iconXax), ICON_WIDTH, ICON_WIDTH);

    // hide the default disclosure icon and position the custom one
    self.accessoryType         = UITableViewCellAccessoryNone;
    NSInteger disclosureXax    = self.bgViewSelected.frame.size.height / 2 - 
                                 self.disclosureImage.frame.size.width / 2;    
    self.disclosureImage.frame = CGRectMake(305, floorf(disclosureXax), 
                                            self.disclosureImage.frame.size.width, 
                                            self.disclosureImage.frame.size.height);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TTTableViewCell

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (selected) {        
        [self setTableCell:TableCellStateSelect];
    } 
    else {
        if (animated) {
            [UIView animateWithDuration:0.2 
                                  delay:0.2 
                                options:UIViewAnimationOptionBeginFromCurrentState                
                             animations:^ {
                                 [self setTableCell:TableCellStateNormal];
                             }
                             completion:nil 
             ];
        } 
        else {
            [self setTableCell:TableCellStateNormal];
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {    
    if (highlighted) {        
        [self setTableCell:TableCellStateSelect];
    } 
    else {
        if (animated) {
            [UIView animateWithDuration:0.2 
                                  delay:0.2 
                                options:UIViewAnimationOptionBeginFromCurrentState                
                             animations:^ {
                                 [self setTableCell:TableCellStateNormal];
                             }
                             completion:nil 
             ];
        } 
        else {
            [self setTableCell:TableCellStateNormal];
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTableCell:(TableCellState)state {
    
    // setup the cell for the normal state
    if (state == TableCellStateNormal) {
        self.textLabel.textColor         = TTSTYLEVAR(forumTableCellTitleTextColor);
        self.textLabel.shadowColor       = TTSTYLEVAR(forumTableCellTitleShadowColor);
        self.detailTextLabel.textColor   = TTSTYLEVAR(forumTableCellDetailTextColor);
        self.detailTextLabel.shadowColor = TTSTYLEVAR(forumTableCellDetailShadowColor);
        
        // put the disclosure icon back to its normal state
        [self.disclosureImage setHighlighted:NO];
        
        // show the selected view's background
        [self.bgViewSelected setAlpha:0];
    }
    
    // setup the cell for the selected state
    if (state == TableCellStateSelect) {
        self.textLabel.textColor         = TTSTYLEVAR(forumTableCellTitleTextColorSelected);
        self.textLabel.shadowColor       = TTSTYLEVAR(forumTableCellTitleShadowColorSelected);
        self.detailTextLabel.textColor   = TTSTYLEVAR(forumTableCellDetailTextColorSelected);
        self.detailTextLabel.shadowColor = TTSTYLEVAR(forumTableCellDetailShadowColorSelected);
        
        // put the disclosure icon to its highlighted state
        [self.disclosureImage setHighlighted:YES];
        
        // show the selected view's background
        [self.bgViewSelected setAlpha:1];
    }
}

@end
