//
//  BlurViewController4.m
//  iosBlurView
//
//  Created by Uber on 18/03/2018.
//  Copyright © 2018 uber. All rights reserved.
//

#import "BlurViewController4.h"

#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"

#define offset 25.f

@interface BlurViewController4 ()
@end

@implementation BlurViewController4

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
    
    
    UIImageView* blurImgView = [UIImageView new];
    blurImgView.frame = CGRectMake(CGRectGetMinX(imageView.frame)+offset,
                                   CGRectGetMinY(imageView.frame)+offset,
                                   CGRectGetWidth(imageView.frame)-offset*2,
                                   CGRectGetHeight(imageView.frame)-offset*2);
    blurImgView.image = [self blurWithCoreImage:image.posterImage withBlurRadius: 10];
    [self.view addSubview:blurImgView];
}


- (UIImage *)takeSnapshotOfView:(UIView *)view
{
    UIGraphicsBeginImageContext(CGSizeMake(view.frame.size.width, view.frame.size.height));
    [view drawViewHierarchyInRect:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height) afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)blurWithCoreImage:(UIImage *)sourceImage withBlurRadius:(CGFloat) blurRadius
{
    CIImage *inputImage = [CIImage imageWithCGImage:sourceImage.CGImage];
    
    // Apply Affine-Clamp filter to stretch the image so that it does not
    // look shrunken when gaussian blur is applied
    CGAffineTransform transform = CGAffineTransformIdentity;
    CIFilter *clampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    [clampFilter setValue:inputImage forKey:@"inputImage"];
    [clampFilter setValue:[NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)] forKey:@"inputTransform"];
    
    // Apply gaussian blur filter with radius of 30
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:clampFilter.outputImage forKey: @"inputImage"];
    [gaussianBlurFilter setValue:@(blurRadius) forKey:@"inputRadius"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:gaussianBlurFilter.outputImage fromRect:[inputImage extent]];
    
    // Set up output context.
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    
    // Invert image coordinates
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.view.frame.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, self.view.frame, cgImage);
    
    // Apply white tint
    CGContextSaveGState(outputContext);
    CGContextSetFillColorWithColor(outputContext, [UIColor colorWithWhite:1 alpha:0.2].CGColor);
    CGContextFillRect(outputContext, self.view.frame);
    CGContextRestoreGState(outputContext);
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

@end
