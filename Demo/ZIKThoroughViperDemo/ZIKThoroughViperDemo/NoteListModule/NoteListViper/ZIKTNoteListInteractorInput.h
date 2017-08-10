//
//  ZIKTNoteListInteractorInput.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZIKTNoteModel;
@protocol ZIKTNoteListInteractorInput <NSObject>
- (void)loadAllNotes;
- (NSInteger)noteCount;
- (NSString *)titleForNoteAtIndex:(NSUInteger)idx;
- (NSString *)contentForNoteAtIndex:(NSUInteger)idx;

- (ZIKTNoteModel *)noteAtIndex:(NSUInteger)idx;
- (NSString *)noteUUIDAtIndex:(NSUInteger)idx;
- (NSString *)noteTitleAtIndex:(NSUInteger)idx;
- (NSString *)noteContentAtIndex:(NSUInteger)idx;
- (void)deleteNoteAtIndex:(NSUInteger)idx;
@end
