//
//  CGPhotoGalleryView.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 10/3/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colors.h"

@interface CGPhotoGalleryView : UIView 
{
    
    NSArray *_photoList;
    NSMutableArray *_galleryList;
    UIButton *_deleteButton;
    
    UIImageView *_testPhoto;
    UIView *_bgView;
    
    NSInteger _pageIndex;
    NSInteger _photoCount;
}

- (id)initWithPoint:(CGPoint)pos andList:(NSArray*)imageList;
- (void)setGallery;

@end
