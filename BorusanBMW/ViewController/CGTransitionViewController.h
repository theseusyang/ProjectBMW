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
#import "RecordEntity.h"
#import "Server.h"
#import <RestKit/RestKit.h>
#import "NotificationTypeResponse.h"
#import "CGCreateRecordViewController.h"
#import "CGInformEditViewController.h"

typedef enum{
    TransitionStateLoader = 0,
    TransitionStateSucceeded
} TransitionState;

typedef enum{
    TransitionTypeInsert = 0,
    TransitionTypeEdit
} TransitionType;

@interface CGTransitionViewController : CGBaseViewController
{
    NSTimer *_timer;
    int _count;
    TransitionType _transitionType;
    
    UIImageView *_loadingImage;
    UIImageView *_iconSucceededImage;
    CGLabel *_topLabel;
    CGLabel *_bottomLabel;
    
    id _object;
    
    int _centerX;
    int _centerY;
    
    Class _classTypeToTurnBack;
    
    RecordEntity *_entity;
    VehicleListResponse *_vehicle;
}
- (id)initWith:(Class)classType;
- (id)initWith:(Class)classType recordEntity:(RecordEntity *)entity andObject:(id)object;
- (id)initWith:(Class)classType editEntity:(RecordEntity *)entity vehicleResponse:(VehicleListResponse *)response andObject:(id)object;
@end


