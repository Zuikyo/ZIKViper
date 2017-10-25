//
//  ZIKEditorAdapter.m
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/24.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKEditorAdapter.h"
#import "ZIKEditorViewRouter.h"
@import ZIKRouter.Internal;

@interface ZIKEditorViewConfiguration (NoteEditorProtocol) <NoteListRequiredNoteEditorProtocol>

@end

@implementation ZIKEditorViewConfiguration (NoteEditorProtocol)

- (void)constructForEditingNote:(ZIKNoteModel *)note {
    [self constructForModifyingNote:note];
}

@end

@implementation ZIKEditorAdapter

+ (void)registerRoutableDestination {
    [ZIKEditorViewRouter registerConfigProtocol:@protocol(NoteListRequiredNoteEditorProtocol)];
}

@end
