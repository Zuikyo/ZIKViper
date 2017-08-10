//
//  ZIKNoteDataManager.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZIKNoteModel;
@interface ZIKNoteDataManager : NSObject
@property (nonatomic, readonly, strong) NSArray<ZIKNoteModel *> *noteList;
+ (instancetype)sharedInsatnce;
- (void)fetchAllNotesWithCompletion:(void(^)(NSArray *notes))completion;
- (void)storeNote:(ZIKNoteModel *)note;
- (void)deleteNote:(ZIKNoteModel *)noteToDelete;
@end
