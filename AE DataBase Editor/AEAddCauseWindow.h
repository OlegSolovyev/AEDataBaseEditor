//
//  AEAddCauseWindow.h
//  AE DataBase Editor
//
//  Created by Oleg Solovyev on 27/05/14.
//  Copyright (c) 2014 Oleg Solovyev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AEAddCauseWindow : NSWindowController
@property (retain) IBOutlet NSTextField *causeTextField;
@property (retain) IBOutlet NSTextView *tagsTextView;
@property (retain) IBOutlet NSTextView *factorsTextView;
@property (weak) IBOutlet NSComboBox *addTagComboBox;
@property (weak) IBOutlet NSComboBox *addFactorComboBox;
@property (weak) IBOutlet NSTextField *probabilityTextField;
@property (weak) IBOutlet NSTextField *linkField;

@property (nonatomic, retain) NSTextView *parentTextView;
@property (nonatomic, retain) NSTextView *dbTextView;

- (IBAction)addTagButtonPressed:(id)sender;
- (IBAction)addFactorButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)undoTagButtonPressed:(id)sender;
- (IBAction)undoFactorButtonPressed:(id)sender;

@end
