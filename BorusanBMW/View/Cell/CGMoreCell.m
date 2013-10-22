//
//  CGMoreCell.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 10/7/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGMoreCell.h"

#define Indicator

@implementation CGMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = kApplicationFont(20.f);
        self.textLabel.backgroundColor = kColorClear;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = kTextColor;
        
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kResButtonLoadMore]];
        self.backgroundView = bgView;
        
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.contentView addSubview:_activityIndicator];
        
        [_activityIndicator setHidden:YES];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.frame = CGRectMake(self.frame.size.width/2 - 50, self.frame.size.height/2 - 20, 0, 0);
    [self.textLabel sizeToFit];
    _activityIndicator.frame = CGRectMake(160 - 7, 22 - 7, 15, 15);
}

- (void)show
{
    self.textLabel.hidden = NO;
}

- (void)hide
{
    self.textLabel.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)startAnimation
{
    [self hide];
    [_activityIndicator setHidden:NO];
    [_activityIndicator startAnimating];
}

- (void)stopAnimation
{
    [self show];
    [_activityIndicator setHidden:YES];
    [_activityIndicator stopAnimating];
}

@end
