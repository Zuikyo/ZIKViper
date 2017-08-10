//
//  ZIKNoteListInteractorInput.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/16.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZIKNoteModel;
@protocol ZIKNoteListInteractorInput <NSObject>
- (BOOL)needValidateAccount;
- (void)didLoginedWithAccount:(NSString *)account;
- (void)loadAllNotes;
- (NSInteger)noteCount;
- (NSString *)titleForNoteAtIndex:(NSUInteger)idx;
- (NSString *)contentForNoteAtIndex:(NSUInteger)idx;

- (ZIKNoteModel *)noteAtIndex:(NSUInteger)idx;
- (void)deleteNoteAtIndex:(NSUInteger)idx;
@end
