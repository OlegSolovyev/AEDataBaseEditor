//
//  AEAddSymptomWindow.m
//  AE DataBase Editor
//
//  Created by Oleg Solovyev on 27/05/14.
//  Copyright (c) 2014 Oleg Solovyev. All rights reserved.
//

#import "AEAddSymptomWindow.h"
#import "AEAddCauseWindow.h"

@interface AEAddSymptomWindow ()
@property (nonatomic, retain) AEAddCauseWindow *addCauseWindow;
@property (nonatomic, retain) NSMutableArray *categories;
@end

@implementation AEAddSymptomWindow

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
        NSLog(@"Init");

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

- (IBAction)addModelButtonPressed:(id)sender {
    if(self.modelsComboBox.stringValue){
        [self.modelsTextView setEditable:YES];
        if([self.modelsTextView.string isEqualToString:@"All"]){
            if(![self.modelsComboBox.stringValue isEqualToString:@""])[self.modelsTextView setString: self.modelsComboBox.stringValue];
        } else{
            [self.modelsTextView setString:[self.modelsTextView.string stringByAppendingString: [NSString stringWithFormat:@";%@", self.modelsComboBox.stringValue]]];
        }
        [self.modelsTextView setEditable:NO];
    }
}

- (IBAction)addCauseButtonPressed:(id)sender {
    self.addCauseWindow= [[AEAddCauseWindow alloc] initWithWindowNibName:@"AEAddCauseWindow"];
    [self.addCauseWindow setParentTextView:self.causesTextView];
    [self.addCauseWindow showWindow:self];
}

- (IBAction)saveButtonPressed:(id)sender {
    if([self.nameTextField.stringValue isEqualToString:@""]){
        [self alert:@"Error" text:@"Please set the name"];
    } else if([self.categoryComboBox.stringValue isEqualToString:@""]){
        [self alert:@"Error" text:@"Please choose the category"];
    } else if([self.causesTextView.string isEqualToString:@""]){
        [self alert:@"Error" text:@"Please add causes"];
    } else{
        int index;
        if([self.parentTextView.string rangeOfString:@"Index:"].location == NSNotFound){
            index = 1;
        } else{
            NSArray *strings = [self.parentTextView.string componentsSeparatedByString:@"\n"];
            for(int i = (int)strings.count - 1; i >= 0; i--){
                NSString *str = [strings objectAtIndex:i];
                if ([str isEqualToString:@"Index:"]) {
                    index = [[strings objectAtIndex:i + 1] intValue] + 1;
                    break;
                }
            }
        }
        NSString *result = [NSString stringWithFormat:@"\nSymptom\nIndex:\n%d\nCategory:\n%@\nName:\n%@\nCauses:\n%@\nModels:\n%@\n", index, self.categoryComboBox.stringValue,self.nameTextField.stringValue,self.causesTextView.string,self.modelsTextView.string ];
        [self.parentTextView setString:[self.parentTextView.string stringByAppendingString:result]];
        [self.window performClose:self];
    }
}

- (IBAction)undoCauseButtonPressed:(id)sender {
    if(![self.causesTextView.string isEqualToString:@""]){
        NSArray *array = [self.causesTextView.string componentsSeparatedByString:@"\n"];
        for(NSString *str in array){
            NSLog(@": %@",str);
        }
        NSString *result = @"";
        
        for(int i = 0; i < array.count - 1; ++i){
            
            result = [result stringByAppendingString:[NSString stringWithFormat:((i == array.count - 2) ? @"%@" : @"%@\n"),[array objectAtIndex:i]]];
            
        }
        NSLog(@"%@end",result);
        [self.causesTextView setString:result];
    }
}
@end
