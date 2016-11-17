//
//  NavigationDrawerPresentationController.m
//  NavigationDrawerDemo
//
//  Created by Nikhil Sahukar on 23/08/15.
//  Copyright (c) 2015 Nikhil Sahukar. All rights reserved.
//

#import "NavigationDrawerPresentationController.h"

@implementation NavigationDrawerPresentationController

@synthesize dimmingView = _dimmingView;

#pragma mark private methods

- (void)prepareDimmingView
{
    _dimmingView = [[UIView alloc] init];
    [[self dimmingView] setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.4]];
    [[self dimmingView] setAlpha:0.0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)];
    [[self dimmingView] addGestureRecognizer:tap];
}

- (void)dimmingViewTapped:(UIGestureRecognizer *)gesture
{
    if([gesture state] == UIGestureRecognizerStateRecognized)
    {
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
    }
}


#pragma mark init

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        [self prepareDimmingView];
    }
    return self;
}

#pragma mark lifecycle methods

- (void)presentationTransitionWillBegin
{
    // Here, we'll set ourselves up for the presentation
    
    UIView* containerView = [self containerView];
    UIViewController* presentedViewController = [self presentedViewController];
    
    // Make sure the dimming view is the size of the container's bounds, and fully transparent
    
    [[self dimmingView] setFrame:[containerView bounds]];
    [[self dimmingView] setAlpha:0.0];
    
    // Insert the dimming view below everything else
    
    [containerView insertSubview:[self dimmingView] atIndex:0];
    
    if([presentedViewController transitionCoordinator])
    {
        [[presentedViewController transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            
            // Fade the dimming view to be fully visible
            
            [[self dimmingView] setAlpha:1.0];
        } completion:nil];
    }
    else
    {
        [[self dimmingView] setAlpha:1.0];
    }
}

- (void)dismissalTransitionWillBegin
{
    // Here, we'll undo what we did in -presentationTransitionWillBegin. Fade the dimming view to be fully transparent
    
    if([[self presentedViewController] transitionCoordinator])
    {
        [[[self presentedViewController] transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            [[self dimmingView] setAlpha:0.0];
        } completion:nil];
    }
    else
    {
        [[self dimmingView] setAlpha:0.0];
    }
}

- (CGSize)sizeForChildContentContainer:(id <UIContentContainer>)container withParentContainerSize:(CGSize)parentSize
{
    // We always want a size that's a third of our parent view width, and just as tall as our parent
    return CGSizeMake(parentSize.width - floorf(parentSize.width / 3.0),
                      parentSize.height);
}

- (void)containerViewWillLayoutSubviews
{
    // Before layout, make sure our dimmingView and presentedView have the correct frame
    [[self dimmingView] setFrame:[[self containerView] bounds]];
    [[self presentedView] setFrame:[self frameOfPresentedViewInContainerView]];
}

- (BOOL)shouldPresentInFullscreen
{
    // This is a full screen presentation
    return YES;
}

- (CGRect)frameOfPresentedViewInContainerView
{
    // Return a rect with the same size as -sizeForChildContentContainer:withParentContainerSize:, and right aligned
    CGRect presentedViewFrame = CGRectZero;
    CGRect containerBounds = [[self containerView] bounds];
    
    presentedViewFrame.size = [self sizeForChildContentContainer:(UIViewController<UIContentContainer> *)[self presentedViewController]
                                         withParentContainerSize:containerBounds.size];
    
//    presentedViewFrame.origin.x = containerBounds.size.width - presentedViewFrame.size.width;
    
    return presentedViewFrame;
}

@end
