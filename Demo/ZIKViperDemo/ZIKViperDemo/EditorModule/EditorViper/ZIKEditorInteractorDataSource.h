//
//  ZIKEditorInteractorDataSource.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZIKEditorInteractorDataSource <NSObject>
- (nullable NSString *)currentEditingNoteTitle;
- (nullable NSString *)currentEditingNoteContent;
@end
