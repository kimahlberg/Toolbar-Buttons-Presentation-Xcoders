//
//  ViewController.m
//  Animated Toolbar Button
//
//  Created by Kim Ahlberg on 2016-09-17.
//  Copyright © 2016 Kim Ahlberg. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+TintedImage.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *colorButtons;

@end

@implementation ViewController
BOOL _locationIsActive = NO;

#pragma mark - IBAction methods

- (IBAction)colorButtonTapped:(UIButton *)sender {
    
    // Update the navigation bar's tint color.
    self.navigationBar.tintColor = sender.tintColor;

    // Remove border from all color buttons.
    for (UIButton *button in self.colorButtons) {
        
        button.layer.borderWidth = 0.0;
    }
    
    // Add a border to highlight the tapped button.
    sender.layer.borderWidth = 3.0;
}

- (IBAction)toggleLocation:(UIBarButtonItem *)sender {

    // If location is active, we deactivate it and return.
    if (_locationIsActive) {
        
        sender.image = [UIImage imageNamed:@"LocationInactive"];
        _locationIsActive = NO;
        return;
    }
    
    // Create the animated image.
    // When using an animated image the tint color isn't applied, we must therefore provide pre-tinted images.
    UIColor *tintColor = self.navigationBar.tintColor;
    UIImage *animatedImage =
    [UIImage animatedImageWithImages:@[
                                       [[UIImage imageNamed:@"LocationInactive"] imageWithTintColor:tintColor],
                                       [[UIImage imageNamed:@"LocationLooking1"] imageWithTintColor:tintColor],
                                       [[UIImage imageNamed:@"LocationLooking2"] imageWithTintColor:tintColor],
                                       [[UIImage imageNamed:@"LocationLooking1"] imageWithTintColor:tintColor]]
                            duration:0.4];
    
    // Set the animated image sequence to the bar button item. It immediately starts animating.
    sender.image = animatedImage;
    
    // Simulate location being acquired after a delay of a few seconds.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4.0 * NSEC_PER_SEC), dispatch_get_main_queue(),
                   ^{
                       // Update the bar button item to indicate the location is now set.
                       sender.image = [UIImage imageNamed:@"LocationActive"];
                       _locationIsActive = YES;
                   });
}

#pragma mark - View setup methods

- (void)viewDidLoad {
    
    // Make the color buttons circular and set their border tint
    // color so we can add circular borders to them later.
    for (UIButton *button in self.colorButtons) {
        
        button.layer.cornerRadius = button.bounds.size.width / 2.0;
        button.layer.borderColor = [button.tintColor CGColor];
    }
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    
    return UIBarPositionTopAttached;
}

@end
