//
//  ZIKTRouter+ZIKTEditor.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/8/2.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import "ZIKTRouter.h"

@protocol ZIKTEditorDelegate;
@interface ZIKTRouter (ZIKTEditor)
+ (UIViewController *)viewForCreatingNoteWithDelegate:(id<ZIKTEditorDelegate>)delegate;
+ (UIViewController *)viewForEditingNoteWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content delegate:(id<ZIKTEditorDelegate>)delegate;
@end
