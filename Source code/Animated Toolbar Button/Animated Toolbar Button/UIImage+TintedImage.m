//
//  UIImage+TintedImage.m
//
//  Created by Kim Ahlberg on 2016-09-17.
//  Copyright © 2016 Kim Ahlberg. All rights reserved.
//

#import "UIImage+TintedImage.h"

@implementation UIImage (TintedImage)

- (UIImage*)imageWithTintColor:(UIColor *)tintColor {

    UIImage *image = self;
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);

    // Compensate for Core Graphics and UIKit using different coordinate systems.
    {
        // Flip the coords from CG* to UI* coords.
        CGContextScaleCTM(context, 1, -1);
        
        // Move the image back into the visible area after flipping it
        CGContextTranslateCTM(context, 0, -image.size.height);
    }
    
    // Clip to alpha channel of the image.
    CGContextClipToMask(context, rect, image.CGImage);

    // Draw a filled rectangle in the tint color.
    [tintColor setFill];
    CGContextAddRect(context, rect);
    CGContextDrawPath(context, kCGPathFill);
    
    // Retrieve the UIImage to return.
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
