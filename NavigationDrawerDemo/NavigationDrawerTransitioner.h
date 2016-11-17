//
//  NavigationDrawerTransitioner.h
//  NavigationDrawerDemo
//
//  Created by Nikhil Sahukar on 23/08/15.
//  Copyright (c) 2015 Nikhil Sahukar. All rights reserved.
//

@import UIKit;

@interface NavigationDrawerAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic) BOOL isPresentation;
@end

@interface NavigationDrawerTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>
@end
