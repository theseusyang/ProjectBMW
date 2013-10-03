//
//  CGCreateRecordViewController.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/6/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGBaseViewController.h"
#import "CGMenuViewController.h"


@interface CGPhotoManagementViewController : CGBaseViewController
{
    
    //MBB
    NSArray *_imageList;
    
    UIView *_photoListView;
    UIButton *_addPhotoButton;
    UIButton *_continueButton;
}

- (id)initWithImageList:(NSArray*)imageLlist;

@end
