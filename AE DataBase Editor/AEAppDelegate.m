//
//  AEAppDelegate.m
//  AE DataBase Editor
//
//  Created by Oleg Solovyev on 27/05/14.
//  Copyright (c) 2014 Oleg Solovyev. All rights reserved.
//

#import "AEAppDelegate.h"
#import "MainViewController.h"

@interface AEAppDelegate()
@property (nonatomic,strong) IBOutlet MainViewController *mainViewController;
@end

@implementation AEAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.mainViewController = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    [self.mainViewController setWindow:self.window];

    [self.window setFrame:NSMakeRect(0, 0, 1280, 840) display:YES];
    [self.window.contentView addSubview:self.mainViewController.view];
    self.mainViewController.view.frame = ((NSView*)self.window.contentView).bounds;
}

@end
