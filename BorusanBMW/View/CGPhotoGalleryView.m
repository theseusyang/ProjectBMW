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

- (id)initWithPoint:(CGPoint)pos andList:(NSArray*)imageList
{
    
    self = [super initWithFrame:CGRectMake(pos.x, pos.y, kGalleryWidth, kGalleryHeight)];
    if (self) {
        
        self.backgroundColor = kColorRed;
        
        _galleryList = [[NSMutableArray alloc] init];
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0 , 0, kGalleryWidth, kGalleryHeight)];
        
        _photoCount = [imageList count];
        
        for (int i = 0; i < [imageList count]; ++i) {
            
            float resizeValue = 0.0;
            UIImage *image = imageList[i];
            UIImageView *photo = [[UIImageView alloc] initWithImage:image];
            photo.contentMode = UIViewContentModeScaleAspectFit;
            photo.frame = CGRectMake(5, 5, 160, 160);
            photo.contentMode = UIViewContentModeScaleAspectFit;
            
            int posX = ((kImageIterate * i) + kImageWidthGap);
            resizeValue = (i * kImageResize);
            photo.frame = CGRectMake(5, 5, 160 - resizeValue, 160 - resizeValue);
            
            //UIView *elementView = [[UIView alloc] initWithFrame:CGRectMake(posX, 13, 170, 170)];
            UIView *elementView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 170 - resizeValue, 170 - resizeValue)];
            elementView.backgroundColor = kColorGray;
            elementView.center = _bgView.center;
            
            CGRect frame = elementView.frame;
            frame = CGRectMake(frame.origin.x + (i * kImageStep), frame.origin.y, frame.size.width, frame.size.height);
            
            elementView.frame = frame;
            
            [elementView addSubview:photo];
            
            [_bgView addSubview:elementView];
            
            [_galleryList addObject:elementView];
        }
        
        [self reverseUIViewArrayIndex:_bgView];
        [self addSubview:_bgView];
        
        self.backgroundColor = kColorClear;

        _pageIndex = 0;
        [self setGallery];
        
        UIView *elementView = [[UIView alloc] initWithFrame:CGRectMake(0, 13, 170, 170)];
        elementView.backgroundColor = kColorGray;
        
    }
    return self;
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
    
    _pageIndex++;
    NSLog(@"swipeRight: pageIndex=%d", _pageIndex);
    
    [UIView animateWithDuration:0.4f animations:^{
        _bgView.frame = CGRectMake((kImageIterate * _pageIndex), 0, kGalleryWidth, kGalleryHeight);
    }];
}

- (void)swipeLeft:(UISwipeGestureRecognizer *)sender
{
    if (_pageIndex <= -(_photoCount - 1)) {
        return;
    }
    
    _pageIndex--;
    NSLog(@"swipeLeft: pageIndex=%d", _pageIndex);
    
    [UIView animateWithDuration:0.4f animations:^{
        _bgView.frame = CGRectMake((kImageIterate * _pageIndex), 0, kGalleryWidth, kGalleryHeight);
    }];
}

@end
