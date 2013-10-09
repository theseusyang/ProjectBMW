//
//  CGUIView.h
//  BorusanBMW
//
//  Created by Bahadır Böge on 10/8/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppInfo.h"


@interface CGUIView : UIView
{
    
}

@property (nonatomic) UIImageView *icon;
@property (nonatomic) UIImageView *background;
@property (nonatomic) UITextView *textView;

-(id)initWithFrame:(CGRect)frame andBackground:(NSString*) background andIcon: (NSString*) icon andText:(NSString*) text;

@end
