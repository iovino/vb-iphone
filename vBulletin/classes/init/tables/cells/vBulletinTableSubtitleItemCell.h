/**
 * @file
 *
 * vBulletin iOS
 * Copyright (c) 2011-2012 Ken Iovino. All Rights Reserved. 
 *
 * This application and it's source code is owned and operated by Ken Iovino. Use of this 
 * application and it's source code is strictly prohibited unless otherwise specified in a written 
 * agreement.
 *
 * This file may not be redistributed in whole or significant part.
 */

// Application's Delegate
#import "vBulletinAppDelegate.h"

/** 
 * Enumeration to determine the table cells current state
 */
typedef enum  {
    TableCellStateNormal, /* The state of the cell is normal */
    TableCellStateSelect  /* The state of the cell is selected */
} TableCellState;

/**
 * @class       vBulletinTableSubtitleItemCell
 * @abstract    The main class used to display table cells throughout the application.
 */
@interface vBulletinTableSubtitleItemCell : TTTableSubtitleItemCell {
    /**
     * We use this view for the selected state of the table cell and the parent property
     * self.backgroundView as the normal state of the cell. This allows us to use custom background
     * images for both states.
     */
    UIView * _bgViewSelected;

    /**
     * The custom background view that's used when the table cell is in the selected state.
     */
    UIImageView * _selectBgImage;

    /**
     * The custom background view that's used when the table cell is in the normal state.
     */
    UIImageView * _normalBgImage;
    
    /**
     * The disclosure icon that's used to indicate that a cell is touchable.
     */
    UIImageView * _disclosureImage;
}

@property (nonatomic, retain) UIView      * bgViewSelected;
@property (nonatomic, retain) UIImageView * selectBgImage;
@property (nonatomic, retain) UIImageView * normalBgImage;
@property (nonatomic, retain) UIImageView * disclosureImage;

/**
 * This method sets up the table cells state, whether it's the default normal state or the selected
 * state, when the user touches the cell.
 *
 * @param TableCellState
 *  The state that the table cell should be in.
 * 
 * @return void
 */
- (void)setTableCell:(TableCellState)state;

@end
