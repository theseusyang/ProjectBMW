//
//  CGBaseViewController.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/4/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGBaseViewController.h"

@interface CGBaseViewController ()

@end

@implementation CGBaseViewController

- (id)init
{
    self = [super init];
    if (self) {
        // iOS 7 compatibility code block
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
                self.edgesForExtendedLayout = UIRectEdgeNone;
                //self.automaticallyAdjustsScrollViewInsets = NO;
            }
        }
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    _bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kResBackground]];
    [self.view addSubview:_bg];
    
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _spinner.center = self.view.center;
    [self.view addSubview:_spinner];
    
    // iOS 7 Navigation Button Implementation
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        _leftButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 8, 120, 54)];
        _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(-10, 8, 120, 50)];
        [_leftButton setBackgroundImage:[UIImage imageNamed:kResLabelBack] forState:UIControlStateNormal];
        [_leftButton setBackgroundImage:kApplicationImage(kResLabelBackPressed) forState:UIControlStateHighlighted];
        [_leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
        [_leftButtonView addSubview:_leftButton];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftButtonView];
        
        _rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 8, 120, 54)];
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 8, 120, 50)];
        [_rightButton setBackgroundImage:[UIImage imageNamed:kResLabelEdit] forState:UIControlStateNormal];
        [_rightButton setBackgroundImage:[UIImage imageNamed:kResLabelEditPressed] forState:UIControlStateHighlighted];
        [_rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightButtonView addSubview:_rightButton];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButtonView];

    } else {
        
        // iOS 6 and previous Navigation Buttons Implementation
        _leftButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 8, 120, 54)];
        _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, 120, 50)];
        [_leftButton setBackgroundImage:[UIImage imageNamed:kResLabelBack] forState:UIControlStateNormal];
        [_leftButton setBackgroundImage:kApplicationImage(kResLabelBackPressed) forState:UIControlStateHighlighted];
        [_leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
        [_leftButtonView addSubview:_leftButton];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftButtonView];
        
        _rightButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 8, 120, 54)];
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, 120, 50)];
        [_rightButton setBackgroundImage:[UIImage imageNamed:kResLabelEdit] forState:UIControlStateNormal];
        [_rightButton setBackgroundImage:[UIImage imageNamed:kResLabelEditPressed] forState:UIControlStateHighlighted];
        [_rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightButtonView addSubview:_rightButton];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButtonView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    //Test View bound specifier
    UIView *viewBound = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 4)];
    [self.view addSubview:viewBound];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)setCancelButton
{
    [_rightButton setBackgroundImage:[UIImage imageNamed:kResLabelCancel] forState:UIControlStateNormal];
    [_rightButton setBackgroundImage:[UIImage imageNamed:kResLabelCancelPressed] forState:UIControlStateHighlighted];
}

- (void)setEditButton
{
    [_rightButton setBackgroundImage:[UIImage imageNamed:kResLabelEdit] forState:UIControlStateNormal];
    [_rightButton setBackgroundImage:[UIImage imageNamed:kResLabelEditPressed] forState:UIControlStateHighlighted];
}

- (void)setRightButtonHidden:(BOOL)state
{
    _rightButtonView.hidden = state;
}

- (void)setLeftButtonHidden:(BOOL)state
{
    _leftButtonView.hidden = state;
}

- (void)startSpinner
{
    [_spinner startAnimating];
}

- (void)stopSpinner
{
    [_spinner stopAnimating];
}

- (void)backToController:(Class)classType
{
    NSArray *viewControllerList =  self.navigationController.viewControllers;
    for (int i=0; i < viewControllerList.count; ++i) {
        UIViewController *vc = [viewControllerList objectAtIndex:i];
        if([vc isMemberOfClass:classType])
        {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }

}

#pragma mark Button Actions
- (void)leftAction:(id)sender
{
    NSLog(@"[leftAction in class] = %@", [self class]);
    [self.navigationController popViewControllerAnimated:(YES)];
}

/*
 * Override this method.
 */
- (void)rightAction:(id)sender
{
    // Do not know where to go
    // Override this method
}

@end
