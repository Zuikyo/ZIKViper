//
//  ZIKTEditorBuilder.h
//  ZIKTViperDemo
//
//  Created by zuik on 2017/8/2.
//  Copyright © 2017年 zuik. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZIKTEditorDelegate,ZIKTViperRouter;
@interface ZIKTEditorBuilder : NSObject
+ (UIViewController *)viewForCreatingNoteWithDelegate:(id<ZIKTEditorDelegate>)delegate router:(id<ZIKTViperRouter>)router;
+ (UIViewController *)viewForEditingNoteWithUUID:(NSString *)uuid title:(NSString *)title content:(NSString *)content delegate:(id<ZIKTEditorDelegate>)delegate router:(id<ZIKTViperRouter>)router;
@end
