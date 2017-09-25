//
//  NoteListRequiredNoteEditorDelegate.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/24.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZIKNoteModel;
//If you need to replace ZIKEditorDelegate with NoteListRequiredNoteEditorDelegate, and their methods' name is different, you need to forward ZIKEditorDelegate to NoteListRequiredNoteEditorDelegate in ZIKEditorAdapter
@protocol NoteListRequiredNoteEditorDelegate <NSObject>
- (void)editor:(UIViewController *)editor didFinishEditNote:(ZIKNoteModel *)note;
@end
