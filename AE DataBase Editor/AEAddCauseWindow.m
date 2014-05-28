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
    self.probabilityTextField.stringValue = @"50";
    
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
    } else if(self.probabilityTextField.intValue > 100 || self.probabilityTextField.intValue < 0){
        [self alert:@"Error" text:@"Probability must be between 0 and 100 per cent"];
        if(self.probabilityTextField.intValue < 0){
            self.probabilityTextField.stringValue = @"0";
        } else{
            self.probabilityTextField.stringValue = @"100";
        }
    } else{
        NSString *result = [NSString stringWithFormat:@"%@:%@%@",self.causeTextView.string,self.probabilityTextField.stringValue, self.tagsTextView.string];
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
