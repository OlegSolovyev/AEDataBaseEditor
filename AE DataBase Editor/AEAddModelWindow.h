//
//  AEAddModelWindow.h
//  AE DataBase Editor
//
//  Created by Oleg Solovyev on 27/05/14.
//  Copyright (c) 2014 Oleg Solovyev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AEAddModelWindow : NSWindowController
@property (weak) IBOutlet NSScrollView *tableView;
@property (weak) IBOutlet NSScrollView *textView;
- (IBAction)saveButtonPressed:(id)sender;

@end
