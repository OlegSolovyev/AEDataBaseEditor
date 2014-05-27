//
//  AEAddCauseWindow.h
//  AE DataBase Editor
//
//  Created by Oleg Solovyev on 27/05/14.
//  Copyright (c) 2014 Oleg Solovyev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AEAddCauseWindow : NSWindowController
@property (weak) IBOutlet NSScrollView *causeTextView;
@property (weak) IBOutlet NSScrollView *tagsTextView;
@property (weak) IBOutlet NSComboBox *addTagComboBox;
- (IBAction)addTagButtonPressed:(id)sender;

@end
