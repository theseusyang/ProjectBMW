//
//  CGMenuViewController.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/5/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGBaseViewController.h"

@interface CGMenuViewController : CGBaseViewController
{
    UIImageView *_contentImageView;
    UIImageView *_logoView;
    UIButton    *_newInformButton;
    UIImageView *_newInformButtonImage;
    UIButton    *_informHistory;
    UIImageView *_informHistoryImage;
    
    //Photo Picker
    UIImagePickerController *_imagePicker;
}

@end
