//
//  MainViewController.h
//  AE DataBase Editor
//
//  Created by Oleg Solovyev on 27/05/14.
//  Copyright (c) 2014 Oleg Solovyev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainViewController : NSViewController
@property (weak) IBOutlet NSButton *openButton;
@property (retain) IBOutlet NSTextView *dbView;
@property (nonatomic, retain) NSString *dbPath;
@property (nonatomic, retain) NSWindow *window;

- (IBAction)openButtonPressed:(id)sender;
- (IBAction)addSymptomButtonPressed:(id)sender;
- (IBAction)saveButtonPressed:(id)sender;

@end
