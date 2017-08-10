//
//  ZIKTEditorInteractor.m
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTEditorInteractor.h"
@import ZIKTViper.ZIKTViperInteractorPrivate;
#import "ZIKTEditorInteractorDataSource.h"
#import "ZIKTEditorInteractorEventHandler.h"
#import "ZIKTNoteModel.h"
#import "ZIKTNoteDataManager.h"

@interface ZIKTEditorInteractor () <ZIKTViperInteractorPrivate>
@property (nonatomic, strong, nullable) ZIKTNoteModel *currentEditingNote;
@end

@implementation ZIKTEditorInteractor

- (instancetype)initWithEditingNote:(nullable ZIKTNoteModel *)note {
    if (self = [super init]) {
        if (note) {
            _currentEditingNote = note;
        }
    }
    return self;
}

- (nullable ZIKTNoteModel *)currentEditingNote {
    NSString *title = [self.dataSource currentEditingNoteTitle];
    NSString *content = [self.dataSource currentEditingNoteContent];
    if (!title && !content) {
        return nil;
    }
    if (!_currentEditingNote) {
        _currentEditingNote = [[ZIKTNoteModel alloc] initWithNewNoteForTitle:title content:content];
    } else {
        _currentEditingNote = [[ZIKTNoteModel alloc] initWithUUID:_currentEditingNote.uuid title:title content:content];
    }
    return _currentEditingNote;
}

- (void)storeCurrentEditingNote {
    NSAssert(self.currentEditingNote, @"There is no editing note");
    [[ZIKTNoteDataManager sharedInsatnce] storeNote:self.currentEditingNote];
}

- (nullable NSString *)currentEditingNoteTitle {
    return _currentEditingNote.title;
}

- (nullable NSString *)currentEditingNoteContent {
    return _currentEditingNote.content;
}

@end
