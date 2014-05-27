//
//  AEAddSymptomWindow.m
//  AE DataBase Editor
//
//  Created by Oleg Solovyev on 27/05/14.
//  Copyright (c) 2014 Oleg Solovyev. All rights reserved.
//

#import "AEAddSymptomWindow.h"
#import "AEAddModelWindow.h"
#import "AEAddCauseWindow.h"

@interface AEAddSymptomWindow ()
@property (nonatomic, retain) AEAddModelWindow *addModelWindow;
@property (nonatomic, retain) AEAddCauseWindow *addCauseWindow;
@end

@implementation AEAddSymptomWindow

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here. 
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (IBAction)addModelButtonPressed:(id)sender {
    self.addModelWindow = [[AEAddModelWindow alloc] initWithWindowNibName:@"AEAddModelWindow"];
    [self.addModelWindow showWindow:self];
}

- (IBAction)addCauseButtonPressed:(id)sender {
    self.addCauseWindow= [[AEAddCauseWindow alloc] initWithWindowNibName:@"AEAddCauseWindow"];
    [self.addCauseWindow showWindow:self];
}

- (IBAction)saveButtonPressed:(id)sender {
}
@end
