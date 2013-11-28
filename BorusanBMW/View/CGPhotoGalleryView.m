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
        
        self.self.currentImageList = [NSMutableArray arrayWithArray:[imageList mutableCopy]];
        _parentViewController = vc;
        
        _galleryList = [[NSMutableArray alloc] init];
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0 , 8, kGalleryWidth, kGalleryHeight)];
        
        self.deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 33, 33)];
        [self.deleteButton setImage:[UIImage imageNamed:@"ButtonSquare.png"] forState:UIControlStateNormal];
        [self.deleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _deleteIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconDelete"]];
        _deleteIcon.center = self.deleteButton.center;
        self.deleteButton.center = self.center;
        self.deleteButton.frame = CGRectMake(self.deleteButton.center.x - self.deleteButton.frame.size.width/2, 10, self.deleteButton.frame.size.width, self.deleteButton.frame.size.height);
        [self.deleteButton addSubview:_deleteIcon];

        [self reset];
        [self addSubview:_bgView];
        [self addSubview:self.deleteButton];
    }
    
    return self;
}

- (void)deleteButtonAction:(id)sender
{
    UIView *elementView = [_galleryList objectAtIndex:_exchangeIndex];
    UIImageView *imageView = (UIImageView *)elementView.subviews[1];
    UIImage *image = imageView.image;
    [self.currentImageList removeObject:image];

    if (self.currentImageList.count <= 0)
        [_parentViewController leftAction:self];
    else
        [self reset];
}

- (void)reset
{
    NSArray *viewsToRemove = [_bgView subviews];
    for (UIView *v in viewsToRemove)
        [v removeFromSuperview];
    [_galleryList removeAllObjects];
    
    _pageIndex = 0;
    _exchangeIndex = 0;
    _photoCount = [self.currentImageList count];
    _positionIndexList = [NSMutableArray arrayWithCapacity:[self.currentImageList count]];
    for (int i=0; i < _photoCount; ++i)
        [_positionIndexList addObject:[[NSNumber alloc] initWithInt:i]];

    [self createGallery:self.currentImageList];
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
    // Do not swipe
    if (_pageIndex >= 0) return;
    
    self.deleteButton.hidden = YES;
    //Fade animation for button
    self.deleteButton.alpha = 0;
    
    
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
        
    } completion:^(BOOL finished) {
        self.deleteButton.hidden = NO;
        [self fadeInView:self.deleteButton];
    }];

    _exchangeIndex--;
    _pageIndex++;
    [_bgView bringSubviewToFront:[_galleryList objectAtIndex:_exchangeIndex]];
}

- (void)swipeLeft:(UISwipeGestureRecognizer *)sender
{
    // Do not swipe
    if (_pageIndex <= -(_photoCount - 1)) return;
    
    self.deleteButton.hidden = YES;
    self.deleteButton.alpha = 0;
    
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
    } completion:^(BOOL finished) {
        self.deleteButton.hidden = NO;
        [self fadeInView: self.deleteButton];
    }];
    
    _exchangeIndex++;
    [_bgView bringSubviewToFront:[_galleryList objectAtIndex:_exchangeIndex]];
    _pageIndex--;
}

-(void)fadeInView:(UIView*)imageView
{
    [UIView animateWithDuration:1.0 animations:^{
        imageView.alpha = 1.0;
    }];

}

@end
