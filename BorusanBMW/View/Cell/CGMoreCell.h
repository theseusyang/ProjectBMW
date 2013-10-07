//
//  CGMoreCell.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 10/7/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colors.h"
#import "AppInfo.h"

@interface CGMoreCell : UITableViewCell
{
    UIActivityIndicatorView *_activityIndicator;
}

- (void)startAnimation;
- (void)stopAnimation;

@end
