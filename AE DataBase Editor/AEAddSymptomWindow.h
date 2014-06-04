//
//  AEAddSymptomWindow.h
//  AE DataBase Editor
//
//  Created by Oleg Solovyev on 27/05/14.
//  Copyright (c) 2014 Oleg Solovyev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AEAddSymptomWindow : NSWindowController <NSComboBoxDataSource, NSComboBoxDelegate>
@property (weak) IBOutlet NSTextField *nameTextField;
@property (retain) IBOutlet NSTextView *modelsTextView;
@property (retain) IBOutlet NSTextView *causesTextView;
@property (weak) IBOutlet NSComboBox *categoryComboBox;
@property (weak) IBOutlet NSComboBox *modelsComboBox;

@property (nonatomic, retain) NSTextView *parentTextView;

- (IBAction)addModelButtonPressed:(id)sender;
- (IBAction)addCauseButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)undoCauseButtonPressed:(id)sender;
- (IBAction)undoModelButtonPressed:(id)sender;

@end
