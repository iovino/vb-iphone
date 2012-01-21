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
 * @class       LauncherController
 * @abstract    The user's homepage after they've logged in or signed up.
 * 
 * @discussion
 * This is the users home screen once they've logged in or signed up. From here they can navigate 
 * to different parts of the application, e.g. the forums, private message, settings, etc. All main
 * parts of the site should be accessible from this screen.
 */
@interface LauncherController : TTViewController <
    TTLauncherViewDelegate, 
    TTImageViewDelegate, 
    UIActionSheetDelegate, 
    UIImagePickerControllerDelegate, 
    UINavigationControllerDelegate
> {
    /**
     * The applications delegate.
     */
    vBulletinAppDelegate * appDelegate;
    
    
}

@end
