//
//  MainViewController.m
//  AE DataBase Editor
//
//  Created by Oleg Solovyev on 27/05/14.
//  Copyright (c) 2014 Oleg Solovyev. All rights reserved.
//

#import "MainViewController.h"
#import "AEAddSymptomWindow.h"

@interface MainViewController ()
@property (nonatomic, retain) AEAddSymptomWindow *addSymptomWindow;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        NSLog(@"Init");
        self.dbPath = @"";
    }
    return self;
}

- (void)alert:(NSString *)message text:(NSString *)text{
    NSAlert *alert = [[NSAlert alloc]init];
    [alert setMessageText:message];
    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert setInformativeText:text];
    [alert beginSheetModalForWindow:self.window
                      modalDelegate:self didEndSelector:nil contextInfo:nil];
}

- (IBAction)openButtonPressed:(id)sender {
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    [openDlg setPrompt:@"Select"];
    
    NSArray* txtType = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@",kUTTypeText]];
    NSLog(@"%@",txtType[0]);
    [openDlg setAllowedFileTypes:@[@"txt"]];
    
    [openDlg beginWithCompletionHandler:^(NSInteger result){
        NSArray* files = [openDlg filenames];
        for(NSString* filePath in files)
        {
            NSURL *url = [[NSURL alloc]initFileURLWithPath:filePath];
            NSString *text;
            if(url)
            {
                text = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
            }
            if(text){
                [self.dbView setString:text];
                [self.dbView setEditable:NO];
            }

            self.dbPath = filePath;
            NSLog(@"%@",filePath);
            //do something with the file at filePath
        }
    }];
}

- (IBAction)addSymptomButtonPressed:(id)sender {
    self.addSymptomWindow = [[AEAddSymptomWindow alloc] initWithWindowNibName:@"AEAddSymptomWindow"];
    [self.addSymptomWindow setParentTextView:self.dbView];
    [self.addSymptomWindow showWindow:self];
}

- (IBAction)saveButtonPressed:(id)sender {
    if([self.dbPath isEqualToString:@""]){
        NSSavePanel*    panel = [NSSavePanel savePanel];
        [panel setAllowedFileTypes:@[@"txt"]];
        [panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result){
            if (result == NSFileHandlingPanelOKButton)
            {
                NSURL*  theFile = [panel URL];
                [self.dbView.string writeToURL:theFile atomically:NO encoding:NSUTF8StringEncoding error:nil];
                // Write the contents in the new format.
            }
        }];
    } else{
        [self.dbView.string writeToFile:self.dbPath
                             atomically:NO
                               encoding:NSUTF8StringEncoding
                                  error:nil];
    }
}

- (int)countOccurencesOfSubString:(NSString *)searchString inString:(NSString *)string {
    unsigned long strCount = [string length] - [[string stringByReplacingOccurrencesOfString:searchString withString:@""] length];
    return (int) strCount / [searchString length];
}

- (int)latestIndex{
    int index;
    NSArray *strings = [self.dbView.string componentsSeparatedByString:@"\n"];
    for(int i = (int)strings.count - 1; i >= 0; i--){
        NSString *str = [strings objectAtIndex:i];
        if ([str isEqualToString:@"Index:"]) {
            index = [[strings objectAtIndex:i + 1] intValue] + 1;
            break;
        }
    }
    NSLog(@"%d",index);
    return index;
}

- (BOOL)modelsAreOK{
    return YES;
}

- (BOOL)categoriesAreOK{
    return YES;
}

- (BOOL)causesAreOk{
    return YES;
}

- (BOOL)sypmtomsHaveAllComponents{
    int index = [self latestIndex];
    if(!index){
        return NO;
    }
    if([self countOccurencesOfSubString:@"Symptom" inString:self.dbView.string] != index){
        return NO;
    }
    if([self countOccurencesOfSubString:@"Index:" inString:self.dbView.string] != index){
        return NO;
    }
    if([self countOccurencesOfSubString:@"Category:" inString:self.dbView.string] != index){
        return NO;
    }
    if([self countOccurencesOfSubString:@"Name:" inString:self.dbView.string] != index){
        return NO;
    }
    if([self countOccurencesOfSubString:@"Causes:" inString:self.dbView.string] != index){
        return NO;
    }
    if([self countOccurencesOfSubString:@"Models:" inString:self.dbView.string] != index){
        return NO;
    }
    if(![self modelsAreOK] || ![self categoriesAreOK] || ![self causesAreOk]){
        return NO;
    }
    return YES;
}

- (IBAction)checkValidButtonPressed:(id)sender {
    if([self.dbView.string isEqualToString:@""]){
        [self alert:@"Error" text:@"Data base is empty"];
    } else if(![self sypmtomsHaveAllComponents]){
        [self alert:@"Error" text:@"Data base is corrupred"];
    } else [self alert:@"Check" text:[NSString stringWithFormat:@"Data base is OK\nSymptoms found: %d",[self latestIndex]]];
}

@end
