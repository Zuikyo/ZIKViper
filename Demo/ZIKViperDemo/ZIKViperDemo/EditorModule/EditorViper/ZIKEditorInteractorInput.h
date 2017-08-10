//
//  ZIKEditorInteractorInput.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZIKNoteModel;
@protocol ZIKEditorInteractorInput <NSObject>
- (nullable ZIKNoteModel *)currentEditingNote;
- (void)storeCurrentEditingNote;

- (nullable NSString *)currentEditingNoteTitle;
- (nullable NSString *)currentEditingNoteContent;
@end

NS_ASSUME_NONNULL_END
