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

- (IBAction)addFactorButtonPressed:(id)sender {
    if(![self.addFactorComboBox.stringValue isEqualToString:@""]){
        [self.factorsTextView setString:[self.factorsTextView.string stringByAppendingString:[NSString stringWithFormat:@"&%@",self.addFactorComboBox.stringValue]]];
    }
}

- (int)latestIndex{
    int index;
    NSArray *strings = [self.dbTextView.string componentsSeparatedByString:@"\n"];
    for(int i = (int)strings.count - 1; i >= 0; i--){
        NSString *str = [strings objectAtIndex:i];
        if ([str isEqualToString:@"Index:"]) {
            index = [[strings objectAtIndex:i + 1] intValue];
            break;
        }
    }
    NSLog(@"%d",index);
    return index;
}



- (IBAction)undoTagButtonPressed:(id)sender {
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

- (IBAction)undoFactorButtonPressed:(id)sender {
    if(![self.factorsTextView.string isEqualToString:@""]){
        NSArray *array = [self.factorsTextView.string componentsSeparatedByString:@"&"];
        NSString *result = @"";
        for(int i = 1; i < array.count - 1; ++i){
            if(array.count > 2){
                result = [result stringByAppendingString:[NSString stringWithFormat:@"&%@",[array objectAtIndex:i]]];
            } else{
                result = @"";
            }
        }
        [self.factorsTextView setString:result];
    }
}

- (IBAction)doneButtonPressed:(id)sender {
    
    self.causeTextField.stringValue = [self.causeTextField.stringValue stringByReplacingOccurrencesOfString:@";" withString:@",-"];
    self.causeTextField.stringValue = [self.causeTextField.stringValue stringByReplacingOccurrencesOfString:@":" withString:@"-"];
    
    if([self.causeTextField.stringValue isEqualToString:@""]){
        [self alert:@"Error" text:@"Please enter the cause"];
    } else if(self.linkField.intValue < 0){
        [self alert:@"Error" text:@"Linked symptom index cannot be less than 0"];
    } else if(self.linkField.intValue > [self latestIndex]){
        [self alert:@"Error" text:@"The symptom index you are trying to link to does not exist"];
    } else if(self.probabilityTextField.intValue > 100 || self.probabilityTextField.intValue < 0){
        [self alert:@"Error" text:@"Probability must be between 0 and 100 per cent"];
        if(self.probabilityTextField.intValue < 0){
            self.probabilityTextField.stringValue = @"0";
        } else{
            self.probabilityTextField.stringValue = @"100";
        }
    } else{
        NSString *result = [NSString stringWithFormat:@"%@:%@$%@%@",self.causeTextField.stringValue,self.probabilityTextField.stringValue, self.linkField.stringValue, self.tagsTextView.string];
        result = [result stringByAppendingString:self.factorsTextView.string];
        if([self.parentTextView.string isEqualToString:@""]){
            [self.parentTextView setString:result];
        } else{
            [self.parentTextView setString:[self.parentTextView.string stringByAppendingString:[NSString stringWithFormat:@"\n%@", result]]];
        }
        [self.window performClose:self];
    }
}

@end
