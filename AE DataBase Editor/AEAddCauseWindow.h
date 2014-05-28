//
//  AEAddCauseWindow.h
//  AE DataBase Editor
//
//  Created by Oleg Solovyev on 27/05/14.
//  Copyright (c) 2014 Oleg Solovyev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AEAddCauseWindow : NSWindowController
@property (retain) IBOutlet NSTextView *causeTextView;
@property (retain) IBOutlet NSTextView *tagsTextView;
@property (weak) IBOutlet NSComboBox *addTagComboBox;
@property (weak) IBOutlet NSTextField *probabilityTextField;

@property (nonatomic, retain) NSTextView *parentTextView;

- (IBAction)addTagButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)undoButtonPressed:(id)sender;

@end
