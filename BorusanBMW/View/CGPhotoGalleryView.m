//
//  CGPhotoGalleryView.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 10/3/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGPhotoGalleryView.h"

#define kGalleryWidth  320
#define kGalleryHeight 185

#define kImageIterate 150
#define kImageWidthGap 15

#define kImageWidth 170
#define kImageHeight 170

#define kImageResize 40
#define kImageStep 80

@implementation CGPhotoGalleryView

- (id)initWithPoint:(CGPoint)pos andList:(NSMutableArray*)imageList andViewController: (CGBaseViewController *)vc
{
    
    self = [super initWithFrame:CGRectMake(pos.x, pos.y, kGalleryWidth, kGalleryHeight)];
    if (self) {
        
        self.backgroundColor = kColorClear;
        
        _realImageList = [NSMutableArray arrayWithArray:[imageList mutableCopy]];
        _parentViewController = vc;
        
        _galleryList = [[NSMutableArray alloc] init];
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0 , 8, kGalleryWidth, kGalleryHeight)];
        
        deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 33, 33)];
        [deleteButton setImage:[UIImage imageNamed:@"ButtonSquare.png"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *deleteIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconDelete"]];
        deleteIcon.center = deleteButton.center;
        deleteButton.center = self.center;
        deleteButton.frame = CGRectMake(deleteButton.center.x - deleteButton.frame.size.width/2, 10, deleteButton.frame.size.width, deleteButton.frame.size.height);
        [deleteButton addSubview:deleteIcon];
        
        _photoCount = [_realImageList count];
        
        _positionIndexList = [NSMutableArray arrayWithCapacity:[_realImageList count]];
        for (int i=0; i < _photoCount; ++i)
            [_positionIndexList addObject:[[NSNumber alloc] initWithInt:i]];
        
        _pageIndex = 0;
        _exchangeIndex = 0;
        
        [self createGallery:_realImageList];
        [self reverseUIViewArrayIndex:_bgView];
        [self setGallery];
        
        [self addSubview:_bgView];
        [self addSubview:deleteButton];
        
        /*TEEST**/
        _testImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kImageHeight, kImageHeight)];
        _testImage.backgroundColor = kColorRed;
        _testImage.contentMode = UIViewContentModeScaleAspectFit;
        //[self addSubview:_testImage];
    }
    
    return self;
}

- (void)deleteButtonAction:(id)sender
{
    UIView *elementView = [_galleryList objectAtIndex:_exchangeIndex];
    UIImageView *imageView = (UIImage *)elementView.subviews[1];
    UIImage *image = imageView.image;
    [_realImageList removeObject:image];

    if (_realImageList.count <= 0) {
        [_parentViewController leftAction:self];     
    }
    else
        [self reset];
    
}

- (void)reset
{
    NSArray *viewsToRemove = [_bgView subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }

    [_galleryList removeAllObjects];
    
    [self createGallery:_realImageList];
    [self reverseUIViewArrayIndex:_bgView];
    [self setGallery];
}

- (void)createGallery:(NSArray *)imageList
{
    for (int i = 0; i < [imageList count]; ++i) {

        UIImage *image = imageList[i];
        UIImageView *photo = [[UIImageView alloc] initWithImage:image];
        photo.frame = CGRectMake(5, 5, 160, 160);
        photo.contentMode = UIViewContentModeScaleAspectFit;
        
        float resizeValue = 0.0;
        resizeValue = (i * kImageResize);
        photo.frame = CGRectMake(5, 5, 160 - resizeValue, 160 - resizeValue);
        
        UIView *elementView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kImageHeight - resizeValue, kImageHeight - resizeValue)];
        elementView.backgroundColor = kColorClear;
        elementView.center = _bgView.center;
        elementView.contentMode = UIViewContentModeScaleAspectFit;
        
        UIView *grayBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kImageHeight - resizeValue, kImageHeight - resizeValue)];
        grayBGView.backgroundColor = kColorGray;
        grayBGView.contentMode = UIViewContentModeScaleAspectFit;
        grayBGView.alpha = 0.6;
        
        CGRect frame = elementView.frame;
        frame = CGRectMake(frame.origin.x + (i * kImageStep), frame.origin.y, frame.size.width, frame.size.height);
        elementView.frame = frame;
        
        [elementView addSubview:grayBGView];
        [elementView addSubview:photo];
        
        [_bgView addSubview:elementView];
        
        [_galleryList addObject:elementView];
    }

}

- (void)reverseUIViewArrayIndex:(UIView *)view
{
    
    for (int i=0; i < view.subviews.count; ++i) {
        for (int j=i + 1; j < view.subviews.count; ++j) {
            [view exchangeSubviewAtIndex:i withSubviewAtIndex:j];
        }
    }
    
}

- (void)setGallery
{
    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    [swipeLeftGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:swipeLeftGesture];
    
    UISwipeGestureRecognizer *swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [swipeRightGesture setDirection: UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizer:swipeRightGesture];
    
}

- (void)swipeRight:(UISwipeGestureRecognizer *)sender
{
    if (_pageIndex >= 0) {
        return;
    }
    for (int j=0; j < _photoCount; ++j) {
        NSNumber *number = [_positionIndexList objectAtIndex:j];
        number = @([number intValue] + 1);
        [_positionIndexList replaceObjectAtIndex:j withObject:number];
    }
    
    [UIView animateWithDuration:0.4f animations:^{
        
        UIImageView *elementView;
        for (int i=0; i < _photoCount; ++i) {
            elementView = _galleryList[i];
            BOOL signValue = 0.0;
            
            NSNumber *positionIndex = _positionIndexList[i];
            if ([positionIndex intValue] <= 0)
                signValue = 1;
            else
                signValue = -1;
            
            CGRect frame = elementView.frame;
            if ([positionIndex intValue] > 0) {
                //Küçülürken daha az hareket edecek
                frame = CGRectMake(frame.origin.x + (kImageStep + kImageResize/2), frame.origin.y - (signValue * kImageResize/2), frame.size.width + (signValue * kImageResize), frame.size.height + (signValue * kImageResize));
            }
            else
            {
                frame = CGRectMake(frame.origin.x + (kImageStep - kImageResize/2), frame.origin.y - (signValue * kImageResize/2), frame.size.width + (signValue * kImageResize), frame.size.height + (signValue * kImageResize));
            }            elementView.frame = frame;
            
            elementView.frame = frame;
            
            UIImageView *bgView    = elementView.subviews[0];
            bgView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
            
            UIImageView *photoView = elementView.subviews[1];
            frame = photoView.frame;
            frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width + (signValue * kImageResize), frame.size.height + (signValue * kImageResize));
            photoView.frame = frame;
            
        }
    }];

    _exchangeIndex--;
    _pageIndex++;
    [_bgView bringSubviewToFront:[_galleryList objectAtIndex:_exchangeIndex]];
}

- (void)swipeLeft:(UISwipeGestureRecognizer *)sender
{
    if (_pageIndex <= -(_photoCount - 1)) {
        return;
    }
    
    for (int j=0; j < _photoCount; ++j) {
        NSNumber *number = [_positionIndexList objectAtIndex:j];
        number = @([number intValue] - 1);
        [_positionIndexList replaceObjectAtIndex:j withObject:number];
    }

    [UIView animateWithDuration:0.4f animations:^{
        UIImageView *elementView;
        for (int i=0; i < _photoCount; ++i) {
            elementView = _galleryList[i];
            
            BOOL signValue = 0.0;
        
            NSNumber *positionIndex = _positionIndexList[i];
            if ([positionIndex intValue] < 0)
                signValue = -1;
            else
                signValue = 1;
            
            CGRect frame = elementView.frame;

            if ([positionIndex intValue] <= -1) {

                frame = CGRectMake(frame.origin.x - (kImageStep - kImageResize/2), frame.origin.y - (signValue * kImageResize/2), frame.size.width + (signValue * kImageResize), frame.size.height + (signValue * kImageResize));
            }
            else
            {
                frame = CGRectMake(frame.origin.x - (kImageStep + kImageResize/2), frame.origin.y - (signValue * kImageResize/2), frame.size.width + (signValue * kImageResize), frame.size.height + (signValue * kImageResize));
            }
            
            elementView.frame = frame;
            
            UIImageView *bgView    = elementView.subviews[0];
            bgView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
            
            UIImageView *photoView = elementView.subviews[1];

            frame = photoView.frame;
            frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width + (signValue * kImageResize), frame.size.height + (signValue * kImageResize));
            photoView.frame = frame;
        }
    }];
    
    _exchangeIndex++;
    [_bgView bringSubviewToFront:[_galleryList objectAtIndex:_exchangeIndex]];
    _pageIndex--;
}

@end
