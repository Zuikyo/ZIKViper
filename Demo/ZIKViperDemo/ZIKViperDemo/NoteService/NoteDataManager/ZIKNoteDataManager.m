//
//  ZIKNoteDataManager.m
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKNoteDataManager.h"
#import "ZIKNoteModel.h"

@interface ZIKNoteDataManager ()
@property (nonatomic, strong) NSMutableArray<NSString *> *noteUUIDs;
@property (nonatomic, strong) NSMutableArray<ZIKNoteModel *> *notes;
@end

@implementation ZIKNoteDataManager
+ (instancetype)sharedInsatnce {
    static ZIKNoteDataManager *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[ZIKNoteDataManager alloc] init];
    });
    return shared;
}

#pragma mark Fetch

- (NSArray<ZIKNoteModel *> *)noteList {
    return [self.notes copy];
}

- (void)fetchAllNotesWithCompletion:(void(^)(NSArray *notes))completion {
    NSAssert([NSThread isMainThread], @"main thread only, otherwise use lock to make thread safety.");
    NSArray *noteList = self.noteList;
    if (!noteList) {
        self.noteUUIDs = [NSMutableArray array];
        self.notes = [NSMutableArray array];
        NSArray<NSString *> *uuids = [self noteListUUIDArray];
        NSMutableArray *notes = [NSMutableArray array];
        for (NSString *uuid in uuids) {
            ZIKNoteModel *note = [self localStoredNoteWithUUID:uuid];
            if (note) {
                [notes addObject:note];
            }
        }
        [self.noteUUIDs addObjectsFromArray:uuids];
        [self.notes addObjectsFromArray:notes];
        noteList = notes;
    }
    if (completion) {
        completion(noteList);
    }
}

- (ZIKNoteModel *)localStoredNoteWithUUID:(NSString *)uuid {
    NSParameterAssert(uuid);
    NSAssert([NSThread isMainThread], @"main thread only, otherwise use lock to make thread safety.");
    ZIKNoteModel *note = [NSKeyedUnarchiver unarchiveObjectWithFile:[ZIKNoteDataManager _o_pathForLocalStoredNoteWithUUID:uuid]];
    return note;
}

- (void)storeNote:(ZIKNoteModel *)noteToStore {
    NSAssert([NSThread isMainThread], @"main thread only, otherwise use lock to make thread safety.");
    NSString *filePath = [ZIKNoteDataManager _o_pathForLocalStoredNoteWithUUID:noteToStore.uuid];
    BOOL success = [NSKeyedArchiver archiveRootObject:noteToStore toFile:filePath];
    NSAssert(success == YES, nil);
    if (success) {
        if (![self.noteUUIDs containsObject:noteToStore.uuid]) {
            [self.noteUUIDs addObject:noteToStore.uuid];
            [self.notes addObject:noteToStore];
            [self storeNoteListUUIDs];
        } else {
            NSUInteger idx;
            for (idx = 0; idx < self.notes.count; idx++) {
                ZIKNoteModel *note = [self.notes objectAtIndex:idx];
                if ([noteToStore.uuid isEqualToString:note.uuid]) {
                    break;
                }
            }
            [self.notes replaceObjectAtIndex:idx withObject:noteToStore];
        }
    }
}

- (void)deleteNote:(ZIKNoteModel *)noteToDelete {
    NSParameterAssert(noteToDelete.uuid);
    
    if (![self.noteUUIDs containsObject:noteToDelete.uuid]) {
        NSAssert(NO, @"note to delete not exists");
        return;
    }
    [self.noteUUIDs removeObject:noteToDelete.uuid];
    [self storeNoteListUUIDs];
    ZIKNoteModel *noteToDeleteInArray;
    for (ZIKNoteModel *note in self.notes) {
        if ([note.uuid isEqualToString:noteToDelete.uuid]) {
            noteToDeleteInArray = note;
            break;
        }
    }
    NSAssert(noteToDeleteInArray != nil, @"didn't find note to delete in notes array");
    [self.notes removeObject:noteToDeleteInArray];
    NSString *filePath = [ZIKNoteDataManager _o_pathForLocalStoredNoteWithUUID:noteToDelete.uuid];
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    NSAssert(error == nil, nil);
}

- (NSArray<NSString *> *)noteListUUIDArray {
    NSAssert([NSThread isMainThread], @"main thread only, otherwise use lock to make thread safety.");
    NSArray * noteListUUIDs = [NSKeyedUnarchiver unarchiveObjectWithFile:[ZIKNoteDataManager _o_pathForNoteListUUIDsFile]];
    if (!noteListUUIDs) {
        return @[];
    }
    return noteListUUIDs;
}

- (void)storeNoteListUUIDs {
    NSAssert([NSThread isMainThread], @"main thread only, otherwise use lock to make thread safety.");
    NSString *filePath = [ZIKNoteDataManager _o_pathForNoteListUUIDsFile];
    BOOL success = [NSKeyedArchiver archiveRootObject:self.noteUUIDs toFile:filePath];
    NSAssert(success == YES, nil);
}

+ (NSString *)_o_pathForNoteListUUIDsFile {
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [document stringByAppendingPathComponent:@"noteUUIDs"];
}

+ (NSString *)_o_pathForLocalStoreNote {
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [document stringByAppendingPathComponent:@"Notes"];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        NSAssert(error == nil, nil);
    });
    return path;
}

+ (NSString *)_o_pathForLocalStoredNoteWithUUID:(NSString *)uuid {
    NSParameterAssert(uuid);
    return [[self _o_pathForLocalStoreNote] stringByAppendingPathComponent:uuid];
}
@end
