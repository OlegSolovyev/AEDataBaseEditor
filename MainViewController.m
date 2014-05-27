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

@end
