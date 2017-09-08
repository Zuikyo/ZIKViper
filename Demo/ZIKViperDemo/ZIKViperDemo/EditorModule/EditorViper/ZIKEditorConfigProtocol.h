//
//  ZIKEditorConfigProtocol.h
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/17.
//  Copyright © 2017 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZIKEditorViewProtocol.h"
@import ZIKRouter;

NS_ASSUME_NONNULL_BEGIN

//If ZIKEditorConfigProtocol is not registered as routable protocol, remember to remove this macro
#define _ZIKEditorConfigProtocol_ (Protocol<ZIKViewConfigRoutable> *)@protocol(ZIKEditorConfigProtocol)

@class ZIKNoteModel;
@protocol ZIKEditorConfigProtocol <ZIKViewConfigRoutable>
@property (nonatomic, assign) BOOL previewing;
@property (nonatomic, weak) id<ZIKEditorDelegate> delegate;
- (void)constructForCreatingNewNote;
- (void)constructForModifyingNote:(ZIKNoteModel *)note;
@end

NS_ASSUME_NONNULL_END
