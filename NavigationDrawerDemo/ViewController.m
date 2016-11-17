//
//  ViewController.m
//  NavigationDrawerDemo
//
//  Created by Nikhil Sahukar on 23/08/15.
//  Copyright (c) 2015 Nikhil Sahukar. All rights reserved.
//

#import "ViewController.h"
#import "MenuTableViewController.h"
#import "NavigationDrawerTransitioner.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize transitioningDelegate = _transitioningDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark actions

- (IBAction)actionMenuPressed:(id)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MenuTableViewController *menuTableViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"menuTableViewController"];
    
    self.transitioningDelegate = [[NavigationDrawerTransitioningDelegate alloc] init];
    [menuTableViewController setTransitioningDelegate:[self transitioningDelegate]];
    
    [self presentViewController:menuTableViewController animated:YES completion:NULL];
    
}


@end
