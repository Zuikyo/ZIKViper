//
//  ZIKTNoteListDataService.h
//  ZIKThoroughViperDemo
//
//  Created by zuik on 2017/8/4.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZIKTNoteModel;
@protocol ZIKTNoteListDataService <NSObject>
@property (nonatomic, readonly, strong) NSArray<ZIKTNoteModel *> *noteList;
- (void)fetchAllNotesWithCompletion:(void(^)(NSArray *notes))completion;
- (void)storeNote:(ZIKTNoteModel *)note;
- (void)deleteNote:(ZIKTNoteModel *)noteToDelete;
@end
