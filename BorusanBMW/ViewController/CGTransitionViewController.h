//
//  CGTransitionViewController.h
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/6/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGBaseViewController.h"
#import "CGMenuViewController.h"
#import "CGLabel.h"

@interface CGTransitionViewController : CGBaseViewController
{
    UIImageView *_loadingImage;
    UIImageView *_iconSucceededImage;
    CGLabel *_topLabel;
    CGLabel *_bottomLabel;
    
    int _centerX;
    int _centerY;
    
    Class _classTypeToTurnBack;
}

- (id)initWith:(Class)classType;

typedef enum{
    TransitionStateLoader = 0,
    TransitionStateSucceeded
} TransitionState;

@end


