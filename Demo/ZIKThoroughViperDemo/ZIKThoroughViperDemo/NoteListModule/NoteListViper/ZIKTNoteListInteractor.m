//
//  ZIKTNoteListInteractor
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTNoteListInteractor.h"
@import ZIKTViper.ZIKTViperInteractorPrivate;
#import "ZIKTNoteModel.h"
#import "ZIKTNoteListDataService.h"

@interface ZIKTNoteListInteractor () <ZIKTViperInteractorPrivate>
@property (nonatomic, strong, nullable) ZIKTNoteModel *currentEditingNote;
@property (nonatomic, strong) id<ZIKTNoteListDataService> noteListDataService;
@end

@implementation ZIKTNoteListInteractor

- (instancetype)initWithNoteListDataService:(id<ZIKTNoteListDataService>)service {
    if (self = [super init]) {
        _noteListDataService = service;
    }
    return self;
}

- (NSArray<ZIKTNoteModel *> *)noteList {
    return self.noteListDataService.noteList;
}

- (void)loadAllNotes {
    [self.noteListDataService fetchAllNotesWithCompletion:^(NSArray *notes) {
        
    }];
}

- (NSInteger)noteCount {
    return self.noteList.count;
}

- (NSString *)titleForNoteAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return [[self.noteList objectAtIndex:idx] title];
}

- (NSString *)contentForNoteAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return [[self.noteList objectAtIndex:idx] content];
}

- (ZIKTNoteModel *)noteAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return [self.noteList objectAtIndex:idx];
}

- (NSString *)noteUUIDAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return [[self.noteList objectAtIndex:idx] uuid];
}

- (NSString *)noteTitleAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return [[self.noteList objectAtIndex:idx] title];
}

- (NSString *)noteContentAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return [[self.noteList objectAtIndex:idx] content];
}

- (void)deleteNoteAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return;
    }
    ZIKTNoteModel *note = [self noteAtIndex:idx];
    [self.noteListDataService deleteNote:note];
}

@end
