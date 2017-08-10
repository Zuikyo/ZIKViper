//
//  ZIKEditorInteractor.m
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKEditorInteractor.h"
#import <ZIKViper/ZIKViperInteractorPrivate.h>
#import "ZIKEditorInteractorDataSource.h"
#import "ZIKEditorInteractorEventHandler.h"
#import "ZIKNoteModel.h"
#import "ZIKNoteDataManager.h"

@interface ZIKEditorInteractor () <ZIKViperInteractorPrivate>
@property (nonatomic, strong, nullable) ZIKNoteModel *currentEditingNote;
@end

@implementation ZIKEditorInteractor

- (instancetype)initWithEditingNote:(nullable ZIKNoteModel *)note {
    if (self = [super init]) {
        if (note) {
            _currentEditingNote = note;
        }
    }
    return self;
}

- (nullable ZIKNoteModel *)currentEditingNote {
    NSString *title = [self.dataSource currentEditingNoteTitle];
    NSString *content = [self.dataSource currentEditingNoteContent];
    if (!title && !content) {
        return nil;
    }
    if (!_currentEditingNote) {
        _currentEditingNote = [[ZIKNoteModel alloc] initWithNewNoteForTitle:title content:content];
    } else {
        _currentEditingNote = [[ZIKNoteModel alloc] initWithUUID:_currentEditingNote.uuid title:title content:content];
    }
    return _currentEditingNote;
}

- (void)storeCurrentEditingNote {
    NSAssert(self.currentEditingNote, @"There is no editing note");
    [[ZIKNoteDataManager sharedInsatnce] storeNote:self.currentEditingNote];
}

- (nullable NSString *)currentEditingNoteTitle {
    return _currentEditingNote.title;
}

- (nullable NSString *)currentEditingNoteContent {
    return _currentEditingNote.content;
}

@end
