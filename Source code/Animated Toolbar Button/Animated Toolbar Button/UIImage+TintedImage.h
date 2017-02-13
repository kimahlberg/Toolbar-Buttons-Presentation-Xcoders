//
//  UIImage+TintedImage.h
//
//  Created by Kim Ahlberg on 2016-09-17.
//  Copyright © 2016 Kim Ahlberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TintedImage)

/**
 * Returns an image tinted with the provided color.
 *
 * @param color     the color to tint the image.
 *
 * @return a UIImage tinted with the provided color.
 */
- (UIImage*)imageWithTintColor:(UIColor *)color;

@end
