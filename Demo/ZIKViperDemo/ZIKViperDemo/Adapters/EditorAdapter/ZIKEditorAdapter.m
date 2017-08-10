//
//  ZIKEditorAdapter.m
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/24.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKEditorAdapter.h"
#import "NoteEditorProtocol.h"
#import "ZIKEditorViewRouter.h"
@import ZIKRouter.Private;

RegisterRoutableViewConfigProtocol(NoteEditorProtocol, ZIKEditorViewRouter)

@interface ZIKEditorViewConfiguration (NoteEditorProtocol) <NoteEditorProtocol>

@end

@implementation ZIKEditorViewConfiguration (NoteEditorProtocol)

- (void)constructForEditingNote:(ZIKNoteModel *)note {
    [self constructForModifyingNote:note];
}

@end

@implementation ZIKEditorAdapter

@end
