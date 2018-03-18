//
//  BlurViewController1.m
//  iosBlurView
//
//  Created by Uber on 16/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "BlurViewController1.h"
#import "UIERealTimeBlurView.h"

#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"

#define offset 25.f
@interface BlurViewController1 ()

@end

@implementation BlurViewController1

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *gifPath = [[NSBundle mainBundle] pathForResource:@"planeGTA1" ofType:@"gif"];
    NSData   *gifData = [NSData dataWithContentsOfFile:gifPath];
    
    
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:gifData];
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.animatedImage = image;
    imageView.frame = CGRectMake(0.0,
                                 self.view.center.y/2,
                                 CGRectGetWidth(self.view.frame),
                                 CGRectGetWidth(self.view.frame));
    [self.view addSubview:imageView];
    
    UIERealTimeBlurView *blur = [[UIERealTimeBlurView alloc] initWithFrame:CGRectMake( CGRectGetMinX(imageView.frame)+offset,
                                                                                       CGRectGetMinY(imageView.frame)+offset, 200, 200)];
    [self.view addSubview:blur];
}



@end
