//
//  AEAddCauseWindow.m
//  AE DataBase Editor
//
//  Created by Oleg Solovyev on 27/05/14.
//  Copyright (c) 2014 Oleg Solovyev. All rights reserved.
//

#import "AEAddCauseWindow.h"

@interface AEAddCauseWindow ()

@end

@implementation AEAddCauseWindow

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

- (void)alert:(NSString *)message text:(NSString *)text{
    NSAlert *alert = [[NSAlert alloc]init];
    [alert setMessageText:message];
    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert setInformativeText:text];
    [alert beginSheetModalForWindow:self.window
                      modalDelegate:self didEndSelector:nil contextInfo:nil];
}

- (IBAction)addTagButtonPressed:(id)sender {
   if(![self.addTagComboBox.stringValue isEqualToString:@""]){
       [self.tagsTextView setString:[self.tagsTextView.string stringByAppendingString:[NSString stringWithFormat:@";%@",self.addTagComboBox.stringValue]]];
   }
}

- (IBAction)doneButtonPressed:(id)sender {
    if([self.causeTextView.string isEqualToString:@""]){
        [self alert:@"Error" text:@"Please enter the cause"];
    } else{
        NSString *result = [self.causeTextView.string stringByAppendingString:self.tagsTextView.string];
        if([self.parentTextView.string isEqualToString:@""]){
            [self.parentTextView setString:result];
        } else{
            [self.parentTextView setString:[self.parentTextView.string stringByAppendingString:[NSString stringWithFormat:@"\n%@", result]]];
        }
        [self.window performClose:self];
    }
}

- (IBAction)undoButtonPressed:(id)sender {
    if(![self.tagsTextView.string isEqualToString:@""]){
        NSArray *array = [self.tagsTextView.string componentsSeparatedByString:@";"];
        NSString *result = @"";
        for(int i = 1; i < array.count - 1; ++i){
            if(array.count > 2){
                result = [result stringByAppendingString:[NSString stringWithFormat:@";%@",[array objectAtIndex:i]]];
            } else{
                result = @"";
            }
        }
        [self.tagsTextView setString:result];
    }
}
@end
