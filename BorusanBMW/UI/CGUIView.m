//
//  CGUIView.m
//  BorusanBMW
//
//  Created by Bahadır Böge on 10/8/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGUIView.h"

@implementation CGUIView

@synthesize icon;
@synthesize background;
@synthesize textView;

- (id)initWithFrame:(CGRect)frame andBackground:(NSString*) backgroundT andIcon: (NSString*) iconT andText:(NSString*) text
{
    
    self = [super initWithFrame:frame];
    if (self) {
       
        UIImage *iconImage = [UIImage imageNamed:iconT];
        UIImage *backgroundImage =[UIImage imageNamed:backgroundT];
        
        icon = [[UIImageView alloc] initWithImage:iconImage];
        icon.frame = CGRectMake(12, 14, iconImage.size.width, iconImage.size.height);
        
        background = [[UIImageView alloc]initWithImage:backgroundImage];
        background.frame = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height);
        
        textView = [[UITextView alloc] initWithFrame:CGRectMake( iconImage.size.width+20, 0, frame.size.width-iconImage.size.width-10, frame.size.height )];
        textView.backgroundColor = [UIColor clearColor];
        textView.font = kApplicationFont(19.0);
        textView.textColor = kTextColor;
        
        
        [self addSubview: background];
        
        [self addSubview: icon];
        [self addSubview: textView];
    }
    
    
    
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
