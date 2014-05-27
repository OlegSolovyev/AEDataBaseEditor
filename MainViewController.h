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

- (IBAction)openButtonPressed:(id)sender;
- (IBAction)addSymptomButtonPressed:(id)sender;

@end
