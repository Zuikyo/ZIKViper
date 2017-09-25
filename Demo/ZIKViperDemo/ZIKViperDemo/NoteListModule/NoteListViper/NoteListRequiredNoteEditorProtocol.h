//
//  NoteEditorProtocol.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/24.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoteEditorDelegate.h"
#import "ZIKEditorDelegate.h"
@import ZIKRouter;

NS_ASSUME_NONNULL_BEGIN

#define NoteListRequiredNoteEditorProtocol_configRoutable @protocol(NoteListRequiredNoteEditorProtocol)

///Reqiured interface of editor module for notelist module
@protocol NoteListRequiredNoteEditorProtocol <ZIKViewConfigRoutable>
@property (nonatomic, assign) BOOL previewing;
@property (nonatomic, weak) id<ZIKEditorDelegate> delegate;
- (void)constructForCreatingNewNote;
- (void)constructForEditingNote:(ZIKNoteModel *)note;
@end

NS_ASSUME_NONNULL_END
