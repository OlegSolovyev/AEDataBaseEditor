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
@property (nonatomic, retain) NSArray *models;
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
    [self loadModels];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

- (void)loadModels{
    NSFileManager *filemgr;
    filemgr = [NSFileManager defaultManager];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"allModels" ofType:@"txt"];
    if ([filemgr fileExistsAtPath: path ] == YES)
        //        NSLog (@"File exists %@", path );
        ;
    else
        NSLog (@"File not found");
    
    NSString *dataBase = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    // first, separate by new line
    self.models = [dataBase componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox{
    if([aComboBox isEqual:self.modelsComboBox]){
        return self.models.count;
    } else{
        return 0;
    }
}

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)loc{
    if([aComboBox isEqual:self.modelsComboBox]){
        return [self.models objectAtIndex:loc];
    } else {
        return nil;
    }
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
            if(![self.modelsComboBox.stringValue isEqualToString:@""])[self.modelsTextView setString: [[NSString stringWithFormat:@";"] stringByAppendingString: self.modelsComboBox.stringValue]];
        } else{
            [self.modelsTextView setString:[self.modelsTextView.string stringByAppendingString: [NSString stringWithFormat:@";%@", self.modelsComboBox.stringValue]]];
        }
        [self.modelsTextView setEditable:NO];
    }
}

- (IBAction)addCauseButtonPressed:(id)sender {
    self.addCauseWindow= [[AEAddCauseWindow alloc] initWithWindowNibName:@"AEAddCauseWindow"];
    [self.addCauseWindow setParentTextView:self.causesTextView];
    [self.addCauseWindow setDbTextView:self.parentTextView];
    [self.addCauseWindow showWindow:self];
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

- (IBAction)undoModelButtonPressed:(id)sender {
    if(![self.modelsTextView.string isEqualToString:@"All"]){
        NSArray *array = [self.modelsTextView.string componentsSeparatedByString:@";"];
        NSString *result = @"";
        for(int i = 1; i < array.count - 1; ++i){
            if(array.count > 2){
                result = [result stringByAppendingString:[NSString stringWithFormat:@";%@",[array objectAtIndex:i]]];
            } else{
                result = @"All";
            }
        }

        [self.modelsTextView setString:result];
    }
}

- (int)countOccurencesOfSubString:(NSString *)searchString inString:(NSString *)string {
    unsigned long strCount = [string length] - [[string stringByReplacingOccurrencesOfString:searchString withString:@""] length];
    NSLog(@"%d", (int) (strCount / [searchString length]));
    return (int) (strCount / [searchString length]);
}

- (IBAction)saveButtonPressed:(id)sender {
    if([self.nameTextField.stringValue isEqualToString:@""]){
        [self alert:@"Error" text:@"Please set the name"];
    } else if([self.categoryComboBox.stringValue isEqualToString:@""]){
        [self alert:@"Error" text:@"Please choose the category"];
    } else if([self.causesTextView.string isEqualToString:@""]){
        [self alert:@"Error" text:@"Please add causes"];
    } else if(![self.modelsTextView.string isEqualToString:@"All"]
              && ([self countOccurencesOfSubString:@":" inString:self.modelsTextView.string] != [self countOccurencesOfSubString:@";" inString:self.modelsTextView.string])){
        [self alert:@"Error" text:@"Model must be of folowing format : 'BrandName:ModelName' "];
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
        [self.modelsTextView setString:[self.modelsTextView.string stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"" ]];
        NSString *result = [NSString stringWithFormat:@"\nSymptom\nIndex:\n%d\nCategory:\n%@\nName:\n%@\nCauses:\n%@\nModels:\n%@\n", index, self.categoryComboBox.stringValue,self.nameTextField.stringValue,self.causesTextView.string,self.modelsTextView.string ];
        [self.parentTextView setString:[self.parentTextView.string stringByAppendingString:result]];
        [self.window performClose:self];
    }
}

@end
