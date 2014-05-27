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
        [self.dbView setEditable:FALSE];
        NSLog(@"%d", self.dbView.isEditable);
    }
    return self;
}

- (IBAction)openButtonPressed:(id)sender {
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    [openDlg setPrompt:@"Select"];
    
    NSArray* txtType = [NSArray arrayWithObject:[NSString stringWithFormat:@"%@",kUTTypeText]];
    NSLog(@"%@",txtType[0]);
    [openDlg setAllowedFileTypes:txtType];
    
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
                [self.dbView insertText:text];
            }
//            else {
//                [self.dbView insertText:@""];
//                
//                
//                NSAlert *alert = [[NSAlert alloc]init];
//                [alert setMessageText:@"Application Message"];
//                [alert setAlertStyle:NSInformationalAlertStyle];
//                [alert setInformativeText:@"Select Only TXT"];
//                [alert beginSheetModalForWindow:self.view.window
//                                  modalDelegate:self didEndSelector:nil contextInfo:nil];
//            }
            self.dbPath = filePath;
            NSLog(@"%@",filePath);
            //do something with the file at filePath
        }
    }];
//    [self.dbView setEditable : NO];
    NSLog(@"%d", self.dbView.isEditable);
}

- (IBAction)addSymptomButtonPressed:(id)sender {
    self.addSymptomWindow = [[AEAddSymptomWindow alloc] initWithWindowNibName:@"AEAddSymptomWindow"];
    [self.addSymptomWindow showWindow:self];
}

@end
