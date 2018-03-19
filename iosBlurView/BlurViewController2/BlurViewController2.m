//
//  BlurViewController2.m
//  iosBlurView
//
//  Created by Uber on 16/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "BlurViewController2.h"

#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"

#define offset 25.f

@interface BlurViewController2 ()

@end

@implementation BlurViewController2

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"planeGTA1" ofType:@"gif"];
    NSData   *gifData = [NSData dataWithContentsOfFile:gifPath];
    
    UIViewAutoresizingFlexibleWidth
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:gifData];
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.animatedImage = image;
    imageView.frame = CGRectMake(0.0,
                                 self.view.center.y/2,
                                 CGRectGetWidth(self.view.frame),
                                 CGRectGetWidth(self.view.frame));
    [self.view addSubview:imageView];
    
   // =============
    
    //only apply the blur if the user hasn't disabled transparency effects
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        
        UIBlurEffect       *blurEffect     = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

        blurEffectView.alpha = 0.7;//945;

        //always fill the view
        blurEffectView.frame = CGRectMake(CGRectGetMinX(imageView.frame)+offset,
                                          CGRectGetMinY(imageView.frame)+offset,
                                          CGRectGetWidth(imageView.frame)-offset*2,
                                          CGRectGetHeight(imageView.frame)-offset*2);
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:blurEffectView];
    }
    
}
@end
