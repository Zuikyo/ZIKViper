//
//  ZIKTNoteListRouter.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/8/2.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <Foundation/Foundation.h>
@import ZIKTViper.ZIKTViperRouter;

@protocol ZIKTLoginViewDelegate,ZIKTEditorDelegate;
@protocol ZIKTNoteListRouter <ZIKTViperRouter>
+ (UIViewController *)loginViewWithMessage:(NSString *)message delegate:(id<ZIKTLoginViewDelegate>)delegate;
+ (UIViewController *)viewForCreatingNoteWithDelegate:(id<ZIKTEditorDelegate>)delegate;
+ (UIViewController *)viewForEditingNoteWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content delegate:(id<ZIKTEditorDelegate>)delegate;
@end
