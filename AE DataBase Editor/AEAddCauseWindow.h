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
@property (weak) IBOutlet NSComboBox *addTagComboBox;
@property (weak) IBOutlet NSTextField *probabilityTextField;
@property (weak) IBOutlet NSTextField *linkField;

@property (nonatomic, retain) NSTextView *parentTextView;
@property (nonatomic, retain) NSTextView *dbTextView;

- (IBAction)addTagButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)undoButtonPressed:(id)sender;

@end
