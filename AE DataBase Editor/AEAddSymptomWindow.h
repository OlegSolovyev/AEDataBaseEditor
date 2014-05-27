//
//  AEAddSymptomWindow.h
//  AE DataBase Editor
//
//  Created by Oleg Solovyev on 27/05/14.
//  Copyright (c) 2014 Oleg Solovyev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AEAddSymptomWindow : NSWindowController
@property (weak) IBOutlet NSTextField *nameTextField;
@property (weak) IBOutlet NSScrollView *modelsTextView;
@property (weak) IBOutlet NSScrollView *causesTextView;
@property (weak) IBOutlet NSComboBox *categoryComboBox;
- (IBAction)addModelButtonPressed:(id)sender;
- (IBAction)addCauseButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;

@end
