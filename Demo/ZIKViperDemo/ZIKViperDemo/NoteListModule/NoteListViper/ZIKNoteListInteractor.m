//
//  ZIKNoteListInteractor
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKNoteListInteractor.h"
#import <ZIKViper/ZIKViperInteractorPrivate.h>
#import "ZIKNoteDataManager.h"
#import "ZIKNoteModel.h"

@interface ZIKNoteListInteractor () <ZIKViperInteractorPrivate>
@property (nonatomic, strong, nullable) ZIKNoteModel *currentEditingNote;
@property (nonatomic, copy) NSString *loginedAccount;
@end

@implementation ZIKNoteListInteractor

- (BOOL)needValidateAccount {
    return self.loginedAccount == nil;
}

- (void)didLoginedWithAccount:(NSString *)account {
    self.loginedAccount = account;
}

- (NSArray<ZIKNoteModel *> *)noteList {
    return [ZIKNoteDataManager sharedInsatnce].noteList;
}

- (void)loadAllNotes {
    [[ZIKNoteDataManager sharedInsatnce] fetchAllNotesWithCompletion:^(NSArray *notes) {
        
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

- (ZIKNoteModel *)noteAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return nil;
    }
    return [self.noteList objectAtIndex:idx];
}

- (void)deleteNoteAtIndex:(NSUInteger)idx {
    if (self.noteList.count - 1 < idx) {
        return;
    }
    ZIKNoteModel *note = [self noteAtIndex:idx];
    [[ZIKNoteDataManager sharedInsatnce] deleteNote:note];
}

@end
