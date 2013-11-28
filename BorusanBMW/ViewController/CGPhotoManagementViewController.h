//
//  CGCreateRecordViewController.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/6/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGBaseViewController.h"
#import "CGMenuViewController.h"
#import "CGPhotoGalleryView.h"


@interface CGPhotoManagementViewController : CGBaseViewController
{
    
    CGPhotoGalleryView *_photoGallery;
    
    //MBB
    NSMutableArray *_imageList;
    //Tesseract Plate Number
    NSString *_plateNumber;
    
    UIView *_photoListView;
    UIButton *_addPhotoButton;
    UIButton *_continueButton;
}

- (id)initWithImageList:(NSMutableArray *)imageLlist;
- (id)initWithImageList:(NSMutableArray *)imageList andPlateNumber: (NSString*)plateNumber;

@end
