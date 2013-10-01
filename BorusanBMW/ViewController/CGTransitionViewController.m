//
//  CGTransitionViewController.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/6/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGTransitionViewController.h"
#import "CGMenuViewController.h"

@interface CGTransitionViewController ()

@end

@implementation CGTransitionViewController

- (id)initWith:(Class)classType
{
    self = [super init];
    if (self) {
        _classTypeToTurnBack = classType;
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    _centerX = (320 - 84) / 2;
    _centerY = (416 - 84) / 2;
    
    _loadingImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Loader.png"]];
    _loadingImage.frame = CGRectMake(118, 130, 84, 84);
    [self.view addSubview:_loadingImage];
    
    _iconSucceededImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IconSucceeded.png"]];
    _iconSucceededImage.frame = CGRectMake(130, 147, 60, 47);
    [_iconSucceededImage setHidden:YES];
    [self.view addSubview:_iconSucceededImage];
    
    _topLabel = [[CGLabel alloc] initWithFrame:CGRectMake(_centerX - 30, _centerY + 80, 120, 16)];
    _topLabel.text = @"Bildiri Gönderiliyor...";
    _topLabel.textAlignment = NSTextAlignmentLeft;
    [_topLabel sizeToFit];
    [self.view addSubview:_topLabel];
    
    _bottomLabel = [[CGLabel alloc] initWithFrame:CGRectMake(_centerX - 4, _centerY + 100, 140, 14)];
    _bottomLabel.text = @"Lütfen bekleyiniz.";
    _bottomLabel.textAlignment = NSTextAlignmentLeft;
    _bottomLabel.font = kApplicationFont(13.0f);
    [_bottomLabel sizeToFit];
    [self.view addSubview:_bottomLabel];
    
    NSNumber *value = [NSNumber numberWithInt:TransitionStateSucceeded];
    id state = value;
    [self performSelector:@selector(changeTransitionState:) withObject:state afterDelay:2.0f];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
    [self setRightButtonHidden:YES];
    [self setLeftButtonHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Change Transition State
- (void)changeTransitionState:(id)transitionState
{
    int state = [transitionState intValue];
    switch (state) {
        case TransitionStateLoader:
            _topLabel.frame = CGRectMake(_centerX - 30, _centerY + 80, 120, 16);
            _topLabel.text = @"Bildiri Gönderiliyor...";
            _bottomLabel.frame = CGRectMake(_centerX - 30, _centerY + 100, 140, 14);
            _bottomLabel.text = @"Lütfen bekleyiniz.";
            [_topLabel sizeToFit];
            [_bottomLabel sizeToFit];
            break;
        case TransitionStateSucceeded:
            _topLabel.frame = CGRectMake(_centerX - 20, _centerY + 80, 120, 16);
            _topLabel.text = @"Bildiri Gönderildi!";
            _bottomLabel.frame = CGRectMake(_centerX + 10, _centerY + 104, 140, 14);
            _bottomLabel.text = @"Teşekkürler.";
            [_topLabel sizeToFit];
            [_bottomLabel sizeToFit];
            break;
    }
    
    [_loadingImage setHidden:!_loadingImage.isHidden];
    [_iconSucceededImage setHidden:!_iconSucceededImage.isHidden];
    
    [self performSelector:@selector(backToMenu) withObject:nil afterDelay:2.0f];
}

- (void)backToMenu
{
    NSLog(@"Back to the future...");
    //[self.navigationController popToViewController:_viewControllerToReturn animated:YES];
    [self backToController:_classTypeToTurnBack];
}

@end
